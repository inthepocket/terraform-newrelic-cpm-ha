output "newrelic_security_group_id" {
  description = "ID of the newrelic security group of VPC"
  value       = aws_security_group.newrelic_cpm.id
}
