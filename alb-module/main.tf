# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Get only the public subnets based on name prefix
data "aws_subnets" "default_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Name"
    values = ["aws-default-public-subnet-*"]
  }
}

output "default_public_subnets" {
  value = data.aws_subnets.default_public.ids
}

module "vm" {
  source         = "./vm"
  amiid          = var.amiid
  key            = var.key
  instance_count = var.instance_count
  sgp            = var.sgp
  vmspec         = var.vmspec
  tagging        = var.tagging
}

module "app-alb" {
  source          = "./app-alb"
  security_groups = var.sgp
  vpc_id          = data.aws_vpc.default.id
  subnet_ids      = data.aws_subnets.default_public.ids
  instance_map    = module.vm.instance_id_map
}