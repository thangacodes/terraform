output "oidc_thumbprint_value" {
  description = "The OIDC thumbprint as read from terraform.tfvars"
  value       = var.oidc_thumbprint
}

output "openid_providerId" {
  value = aws_iam_openid_connect_provider.oidc.id
}
