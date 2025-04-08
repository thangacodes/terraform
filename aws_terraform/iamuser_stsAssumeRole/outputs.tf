output "captain_user_name" {
  value = data.aws_iam_user.admin.user_name
}
output "finding_role_name" {
  value = aws_iam_role.dev_role.name
}
output "finding_role_arn" {
  value = aws_iam_role.dev_role.arn
}

output "newuser_name" {
  value = aws_iam_user.new_user.name
}
output "newuser_arn" {
  value = aws_iam_user.new_user.arn
}
