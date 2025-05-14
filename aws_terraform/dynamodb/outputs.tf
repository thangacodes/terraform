output "dynamodb_id" {
  value = aws_dynamodb_table.account.id
}
output "dynamodb_arn" {
  value = aws_dynamodb_table.account.arn
}

output "dynamodb_attributes" {
  value = aws_dynamodb_table.account.attribute
}
