terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

## local block

locals {
  ec2_nodes = {
    jenkins = {
      name   = "jenkins-server"
      vmspec = "t2.large"
    }
    bastion = {
      name   = "bastion-host"
      vmspec = "t2.micro"
    }
    web = {
      name   = "web-server"
      vmspec = "t2.micro"
    }
  }
}

resource "aws_instance" "nodes" {
  for_each                    = local.ec2_nodes
  ami                         = var.ami_id
  instance_type               = each.value.vmspec
  vpc_security_group_ids      = var.sgp
  key_name                    = var.sshkey
  associate_public_ip_address = true

  tags = {
    Name         = each.value.name
    ServerRole   = each.key
    Owner        = "admin@try-devops.xyz"
    Project      = "DevOps"
    CreationDate = "12/12/2025"
  }
}
