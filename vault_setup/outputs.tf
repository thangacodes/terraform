output "vault_pubendpoint" {
  value = "http://${aws_instance.vault.public_ip}:8200/"
}

output "vault_pvtendpoint" {
  value = "http://${aws_instance.vault.private_ip}:8200/"
}
