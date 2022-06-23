################################################################################
# Locals
# These are used to visualize the cloud-init config in several parts.
################################################################################
locals {
  template_user_data = templatefile("${path.module}/templates/user-data.tftpl",
    {
      cpm_container            = var.newrelic_cpm_container
      cpm_private_location_key = var.newrelic_private_location_key
  })
}

################################################################################
# Resources
################################################################################
data "aws_ami" "amzn" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


resource "aws_launch_template" "newrelic_cpm" {
  name_prefix   = "newrelic-cpm"
  image_id      = data.aws_ami.amzn.id
  instance_type = var.newrelic_cpm_manager_instance_type
  user_data     = base64encode(local.template_user_data)

  vpc_security_group_ids = [aws_security_group.newrelic_cpm.id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.newrelic_cpm_manager_volume_size
    }
  }
}

resource "aws_autoscaling_group" "newrelic_cpm" {
  name               = "newrelic-cpm-group"
  desired_capacity   = var.min_instances
  max_size           = var.max_instances
  min_size           = var.min_instances
  vpc_zone_identifier = [var.vpc_subnet_id]

  launch_template {
    id      = aws_launch_template.newrelic_cpm.id
    version = "$Latest"
  }
}

resource "aws_security_group" "newrelic_cpm" {
  name        = "newrelic-cpm-ha"
  description = "Security group for the newrelic-cpm"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
