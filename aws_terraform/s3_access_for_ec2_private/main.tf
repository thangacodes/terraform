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
  region  = var.region
  profile = "captain"
}

########################
# VARIABLES
########################
variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "ami_id" {
  default = "ami-0ced6a024bb18ff2e" # Amazon Linux 2023 AMI
}

variable "instance_type" {
  default = "t3.micro"
}

########################
# VPC
########################
resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

########################
# Subnets
########################
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name  = "Public-Subnet"
    Env   = "Development"
    Owner = "td@example.com"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "ap-south-1a"
  tags = {
    Name  = "Private-Subnet"
    Env   = "Development"
    Owner = "td@example.com"
  }
}

########################
# Internet Gateway
########################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

########################
# Route Tables
########################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

########################
# Security Groups
########################

# Public Security Group
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Allow SSH from anywhere and traffic from private SG"
  vpc_id      = aws_vpc.myvpc.id

  # Allow SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Public-SG"
    Env   = "Development"
    Owner = "td@example.com"
  }
}

# Private Security Group
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow traffic within private SG and to public SG"
  vpc_id      = aws_vpc.myvpc.id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Private-SG"
    Env   = "Development"
    Owner = "td@example.com"
  }
}

# Create a separate security group rule for allowing private_sg_id in public_sg_id as an inbound rule resource 
resource "aws_security_group_rule" "allow_private_to_public" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.public_sg.id
  source_security_group_id = aws_security_group.private_sg.id
}

# Create a separate security group rule for allowing public_sg in private_sg_id as an inbound rule 
resource "aws_security_group_rule" "allow_public_to_private" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.private_sg.id
  source_security_group_id = aws_security_group.public_sg.id
}

########################
# IAM Role & Policy
########################
resource "aws_iam_role" "s3_role" {
  name = "PrivateEC2S3Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
  tags = {
    Name  = "PrivateEC2S3Role"
    Env   = "Development"
    Owner = "td@example.com"
  }
}

resource "aws_iam_policy" "s3_policy" {
  name = "s3-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowAllS3"
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_instance_profile" "s3_profile" {
  name = "private-ec2-profile"
  role = aws_iam_role.s3_role.name
}

########################
# EC2 Instances using for_each
########################
locals {
  instances = {
    "public-vm"  = { subnet_id = aws_subnet.public.id, sg_id = aws_security_group.public_sg.id }
    "private-vm" = { subnet_id = aws_subnet.private.id, sg_id = aws_security_group.private_sg.id }
  }
}

resource "aws_instance" "ec2" {
  for_each               = local.instances
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [each.value.sg_id]
  key_name               = "captain"
  availability_zone      = "ap-south-1a"
  user_data              = each.key == "private-vm" ? file("${path.module}/script.sh") : null
  metadata_options {
    http_tokens = "required" # IMDSv2 enforced
  }

  tags = {
    Name  = each.key
    Env   = "Development"
    Owner = "td@example.com"
  }

  # Attach IAM Instance Profile only to private-vm
  iam_instance_profile = each.key == "private-vm" ? aws_iam_instance_profile.s3_profile.name : null
}

########################
# S3 VPC Gateway Endpoint:
########################
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.myvpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private_rt.id]
  tags = {
    Name  = "S3EC2-VPCGatewayEndpoint"
    Env   = "Development"
    Owner = "td@example.com"
  }
}

########################
## Output Section:
########################

output "public_vm_ip" {
  value = aws_instance.ec2["public-vm"].public_ip
}

output "public_vm_privateip" {
  value = aws_instance.ec2["public-vm"].private_ip
}

output "private_vm_ip" {
  value = aws_instance.ec2["private-vm"].private_ip
}

output "ec2_iam_profile" {
  value = aws_iam_role.s3_role.name
}

output "Private_sgp_id" {
  value = aws_security_group.private_sg.id
}

output "Public_sgp_id" {
  value = aws_security_group.public_sg.id
}
