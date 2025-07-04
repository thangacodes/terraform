output "modvm_publicip" {
  value = aws_instance.modvm.public_ip
}
output "modvm_privateip" {
  value = aws_instance.modvm.private_ip
}
output "modvm_tagging" {
  value = aws_instance.modvm.tags_all
}
