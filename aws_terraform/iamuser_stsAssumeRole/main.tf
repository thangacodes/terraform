# Fetch the 'captain' IAM user details using the data source
data "aws_iam_user" "admin" {
  user_name = "captain" # The existing IAM user whose details you want to fetch
}
# Create an inline policy that allows the 'captain' IAM user to assume the role
resource "aws_iam_user_policy" "captain_assume_admin_role" {
  name = "captain-assume-admin-role-policy"
  user = data.aws_iam_user.admin.user_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = "arn:aws:iam::${var.account_id}:role/${var.role_name}" # Dynamically reference the role ARN
      }
    ]
  })
}
# Create an IAM Role called 'admin-role'
resource "aws_iam_role" "dev_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "AWS" = [
            "arn:aws:iam::${var.account_id}:user/${var.iamuser}",
            "arn:aws:iam::${var.account_id}:user/${data.aws_iam_user.admin.user_name}"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
# Create an IAM user called 'siju'
resource "aws_iam_user" "new_user" {
  name = var.iamuser
}
# Creating an inline policy
resource "aws_iam_policy" "inline_policy" {
  name        = "${var.iamuser}-assume-role-policy"
  description = "Policy to allow assuming the dev-role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
      }
    ]
  })
}
# Attaching an inline policy to the user called 'siju'
resource "aws_iam_user_policy_attachment" "attach_inline_policy" {
  user       = aws_iam_user.new_user.name
  policy_arn = aws_iam_policy.inline_policy.arn
}
# Null resource to run the AWS CLI command
resource "null_resource" "assume_role_cli" {
  depends_on = [
    aws_iam_role.dev_role,
    aws_iam_user.new_user
  ]
  provisioner "local-exec" {
    command = <<EOT
      aws sts assume-role --role-arn arn:aws:iam::${var.account_id}:role/${var.role_name} \
      --role-session-name clisession --profile ${var.shared_profile} --duration-seconds 900
    EOT
  }
}
