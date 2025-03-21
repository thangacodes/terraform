variable "region" {}
variable "vmspec" {}
variable "sshkey" {}
variable "sgp" {}
variable "profile" {}
variable "amiid" {}

variable "create_ec2_instances" {
  description = "Condition to create EC2 instances"
  type        = bool
  default     = true  // Set to `false` to skip EC2 creation
}

variable "instance_count" {
  description = "Number of EC2 instances to be created"
  type        = number
}
