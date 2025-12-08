variable "kinesis_stream_arn" {
  default = "arn:aws:kinesis:ap-south-1:282526987315:stream/testing-epa-app"
}

variable "s3_bucket_arn" {
  default = "arn:aws:s3:::testing-epa-application-bucket19112025"
}

resource "aws_cognito_identity_pool" "log_pool" {
  identity_pool_name               = "cross-account-log-identity-pool"
  allow_unauthenticated_identities = false
  developer_provider_name          = "login.mycompany.myapp"
}

data "aws_iam_policy_document" "cognito_auth_role_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.log_pool.id]
    }
    condition {
      test     = "StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["authenticated"]
    }
  }
}

resource "aws_iam_role" "cognito_auth_role" {
  name               = "cognito-auth-role"
  assume_role_policy = data.aws_iam_policy_document.cognito_auth_role_trust.json
}