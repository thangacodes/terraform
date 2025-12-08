terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "kinesis_stream_arn" {
  default = "arn:aws:kinesis:ap-south-1:282526987315:stream/testing-epa-app"
}

variable "s3_bucket_arn" {
  default = "arn:aws:s3:::testing-epa-application-bucket19112025"
}

# Extract bucket name from ARN
locals {
  s3_bucket_name = replace(var.s3_bucket_arn, "arn:aws:s3:::", "")
}

# ----------------------------
# Cognito Identity Pool
# ----------------------------
resource "aws_cognito_identity_pool" "log_pool" {
  identity_pool_name               = "cross-account-log-identity-pool"
  allow_unauthenticated_identities = false
}

# ----------------------------
# IAM Trust Policy for Cognito Auth Role
# ----------------------------
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

# ----------------------------
# Cognito Auth IAM Role
# ----------------------------
resource "aws_iam_role" "cognito_auth_role" {
  name               = "cognito-auth-role"
  assume_role_policy = data.aws_iam_policy_document.cognito_auth_role_trust.json
}

# ----------------------------
# IAM Policy – Allow Put to Kinesis + S3
# ----------------------------
data "aws_iam_policy_document" "cognito_auth_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "kinesis:PutRecord",
      "kinesis:PutRecords"
    ]
    resources = [
      var.kinesis_stream_arn
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/env/*"
    ]
  }
}

resource "aws_iam_policy" "cognito_auth_policy" {
  name   = "cognito-auth-role-policy"
  policy = data.aws_iam_policy_document.cognito_auth_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "cognito_auth_role_attach" {
  role       = aws_iam_role.cognito_auth_role.name
  policy_arn = aws_iam_policy.cognito_auth_policy.arn
}

# ----------------------------
# Attach Role to Identity Pool (VERY IMPORTANT)
# ----------------------------
resource "aws_cognito_identity_pool_roles_attachment" "attach_roles" {
  identity_pool_id = aws_cognito_identity_pool.log_pool.id

  roles = {
    authenticated = aws_iam_role.cognito_auth_role.arn
  }
}
