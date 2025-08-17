terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
  }
}

provider "aws" {
  access_key = "PROVIDE YOUR ACCESS KEY"
  secret_key = "PROVIDE YOUR SECRET ACCESS KEY"
  region     = "ap-south-1"
}

resource "aws_vpc" "project-vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name        = "dev-vpc"
    Environment = "development"
  }

}

resource "aws_s3_bucket" "demo" {
  for_each = {
    "dev"   = "gitops-devbucket-dev"
    "stage" = "gitops-devbucket-stage"
    "prod"  = "gitops-devbucket-prod"
  }
  bucket = "${each.key}-${each.value}"
  tags = {
    Environment = each.key
    bucket_name = each.value
  }
  depends_on = [aws_vpc.project-vpc]
}

# Datatype toset in Terraform
# resource "aws_iam_user" "projectusers" {
#   for_each = to_set(["TomC", "SijuMP", "VijayKP"])
#   name     = each.key
#   tags = {
#     Name = each.key
#   }
# }

## [ OR ]
## # Datatype map in Terraform
resource "aws_iam_user" "projectusers" {
  for_each = {
    "developer" = "Vijay"
    "devops"    = "Thangadurai"
    "dba"       = "Anvika"
  }
  name = each.value
  tags = {
    Name = each.value
    Role = each.key
  }
  depends_on = [aws_vpc.project-vpc]
}
