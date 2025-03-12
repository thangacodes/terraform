resource "random_password" "dynamic_password" {
  length  = var.password_length
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "aws_ssm_parameter" "generated_password" {
  name        = var.ssm_param_name
  description = "Generated password stored in Parameter Store"
  type        = "SecureString"
  value = random_password.dynamic_password.result
}
