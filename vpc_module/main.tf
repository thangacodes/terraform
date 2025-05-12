module "vpc" {
  source           = "./vpc"
  cidr_block       = var.cidr_block
  pub_subnet_count = var.pub_subnet_count
  pvt_subnet_count = var.pvt_subnet_count
  tagging          = var.tagging
}
