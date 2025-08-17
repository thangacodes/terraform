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
resource "aws_subnet" "project-subnet" {
  for_each = {
    "app-subnet"      = "192.168.1.0/24"
    "db-subnet"       = "192.168.2.0/24"
    "bastion-subnet"  = "192.168.3.0/24"
    "reserved-subnet" = "192.168.4.0/24"
  }
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = each.value
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = each.key == "bastion-subnet" ? true : false
  tags = {
    Name     = each.key
    Division = each.value
  }
  depends_on = [aws_vpc.project-vpc]
}
resource "aws_s3_bucket" "demo" {
  for_each = {
    "dev"   = "gitops-devbucket-log"
    "stage" = "gitops-devbucket-log"
    "prod"  = "gitops-devbucket-log"
  }
  bucket = "${each.key}-${each.value}"
  tags = {
    Environment = each.key
    bucket_name = each.value
  }
}

# Datatype toset in Terraform
# resource "aws_iam_user" "projectusers" {
#   for_each = to_set(["TomCruise", "Siju", "Vijay"])
#   name     = each.key
#   tags = {
#     Name = each.key
#   }
# }

## [ OR ]
## # Datatype map in Terraform
resource "aws_iam_user" "projectusers" {
  for_each = {
    "developer" = "Simon"
    "devops"    = "Steve"
    "dba"       = "Smith"
  }
  name = each.value
  tags = {
    Name = each.value
    Role = each.key
  }
}
