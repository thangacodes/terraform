terraform {
  required_version = ">= 1.14.2, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "captain"
}

variable "dev_instances" {
  default = {
    devvm1 = 4
    devvm2 = 5
    devvm3 = 6
    devvm4 = 7
    devvm5 = 8
  }
}

# EC2 Instances in ap-south-1a
resource "aws_instance" "devboxes" {
  for_each = var.dev_instances

  ami                    = "ami-02b8269d5e85954ef"
  instance_type          = "t3.micro"
  key_name               = "captain"
  vpc_security_group_ids = ["sg-0c0c0f1dbe99a7816"]
  subnet_id              = "subnet-03cf347f5e938c75e"
  availability_zone      = "ap-south-1a"

  # Only devvm1 gets a public IP
  associate_public_ip_address = each.key == "devvm1" ? true : false

  tags = {
    Name      = each.key
    CreatedOn = "10/01/2026"
    Env       = "dev"
    Owner     = "td@example.com"
    ManagedBy = "Terraform-IaC"
    TFVersion = "v1.14.2"
  }
}

# EBS Volumes in the same AZ (ap-south-1a)
resource "aws_ebs_volume" "dev_ebs" {
  for_each = var.dev_instances

  availability_zone = "ap-south-1a" # Explicit AZ
  size              = each.value

  tags = {
    Name      = "${each.key}-ebs"
    CreatedOn = "10/01/2026"
    Env       = "dev"
    Owner     = "td@example.com"
    ManagedBy = "Terraform-IaC"
    TFVersion = "v1.14.2"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Attach EBS volumes to EC2 instances
resource "aws_volume_attachment" "dev_attach" {
  for_each    = var.dev_instances
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.dev_ebs[each.key].id
  instance_id = aws_instance.devboxes[each.key].id
}
