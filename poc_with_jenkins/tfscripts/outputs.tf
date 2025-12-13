output "instance_name" {
  value = { for key, value in aws_instance.nodes : key => value.tags.Name }
}
output "instance_pubip" {
  value = { for key, value in aws_instance.nodes : key => value.public_ip }
}
output "instance_pvtip" {
  value = { for key, value in aws_instance.nodes : key => value.private_ip }
}

output "jenkins_endpoint" {
  value = "http://${aws_instance.nodes["jenkins"].public_ip}:8080/"
}
