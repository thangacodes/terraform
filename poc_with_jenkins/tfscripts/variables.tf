variable "aws_profile" {
  description = "AWS CLI profile used to connect to AWS APIs"
  type        = string
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "ami_id" {}
variable "sgp" {}
variable "sshkey" {}
