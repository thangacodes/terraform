output "generated_password" {
  value     = random_password.dynamic_password.result
  sensitive = true
}

output "paramstore_name" {
  value = aws_ssm_parameter.generated_password.name
}

output "paramstore_arn" {
  value = aws_ssm_parameter.generated_password.arn
}

output "paramstore_id" {
  value = aws_ssm_parameter.generated_password.id
}
