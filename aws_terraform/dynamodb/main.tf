resource "aws_dynamodb_table" "account" {
  name         = "active_account"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "account_id"

  attribute {
    name = "account_id"
    type = "S"
  }
  tags = var.tagging
}

resource "null_resource" "inject_accounts" {
  depends_on = [aws_dynamodb_table.account]

  provisioner "local-exec" {
    command = "bash ./inject_data.sh"
    environment = {
      AWS_PROFILE = var.profile
      AWS_REGION  = var.region
    }
  }
  triggers = {
    script_hash = filesha256("inject_data.sh")
  }
}
