output "vmpubip" {
  value = aws_instance.web-vm.*.public_ip
}
output "vmpvtip" {
  value = aws_instance.web-vm.*.private_ip
}

output "instance_id_map" {
  value = {
    for idx, id in aws_instance.web-vm[*].id :
    "web-${idx + 1}" => id
  }
}