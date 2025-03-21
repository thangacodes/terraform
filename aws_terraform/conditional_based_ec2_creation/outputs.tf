output "vm_public_ip_finding" {
  value = aws_instance.demo_ec2[*].public_ip
}

output "vm_private_ip_finding" {
  value = aws_instance.demo_ec2[*].private_ip
}

output "vm_name" {
  value = [for instance in aws_instance.demo_ec2 : instance.tags["Name"]]
}
