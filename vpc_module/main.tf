module "vpc" {
  source     = "./vpc"
  cidr_block = var.cidr_block
  tagging    = var.tagging
}
