output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.office.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.office.id
}

output "pub_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "pvt_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "pub_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  value       = [for subnet in aws_subnet.public : subnet.cidr_block]
}

output "availability_zone_ids" {
  description = "List of availability zone IDs used for subnets"
  value       = [for az in data.aws_availability_zones.available.zone_ids : az]
}

output "pvt_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  value       = [for subnet in aws_subnet.private : subnet.cidr_block]
}
