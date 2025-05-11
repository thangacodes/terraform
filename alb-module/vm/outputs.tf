output "vmpubip" {
  value = aws_instance.web-vm.*.public_ip
}
output "vmpvtip" {
  value = aws_instance.web-vm.*.private_ip
}

output "instance_id_map" {
  value = {
    for idx, id in aws_instance.web-vm[*].id :
    "webserver-${idx + 1}" => id
  }
}

output "web_server_public_ips" {
  value = [
    for i in range(var.instance_count) :
    "Web-Server${i + 1}-PublicIP=${aws_instance.web-vm[i].public_ip}"
  ]
}

output "web_server_public_endpoint" {
  value = [
    for i in range(var.instance_count) :
    "Web-Server${i + 1}-PublicEndpoint=http://${aws_instance.web-vm[i].public_ip}"
  ]
}
