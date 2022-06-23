variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_subnet_id" {
  description = "This should refer to the subnet in which you want to spin up the CPM instance"
  type        = string
}

variable "newrelic_cpm_manager_instance_type" {
  description = "The instance type to run per machine."
  type        = string
  default     = "t2.medium"
}

variable "newrelic_cpm_container" {
  description = "The CPM docker container"
  type        = string
  default     = "quay.io/newrelic/synthetics-minion:latest"
}

variable "newrelic_private_location_key" {
  type        = string
  description = "New Relic private location key."
}

variable "newrelic_cpm_manager_volume_size" {
  type        = number
  description = "The EC2 volume size"
  default     = 20
}

variable "min_instances" {
  description = "The minimum of instances"
  type        = number
  default     = 2
}

variable "max_instances" {
  description = "The maximum of instances"
  type        = number
  default     = 3
}
