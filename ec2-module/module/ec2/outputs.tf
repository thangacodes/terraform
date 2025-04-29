output "vmpubip" {
  value = aws_instance.fleetvm.public_ip
}

output "vmpvtip" {
  value = aws_instance.fleetvm.private_ip
}

output "findtag" {
  value = aws_instance.fleetvm.tags_all
}

output "ec2-arn" {
  value = aws_instance.fleetvm.arn
}