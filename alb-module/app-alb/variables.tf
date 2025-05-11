variable "security_groups" {
  description = "Security groups for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnets for ALB"
  type        = list(string)
}

variable "instance_map" {
  description = "Map of EC2 instances to attach to the target group"
  type        = map(string)
}
