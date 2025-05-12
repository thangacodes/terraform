region           = "ap-south-1"
profile          = "vault_admin"
cidr_block       = "192.168.0.0/16"
pvt_subnet_count = 2
pub_subnet_count = 2
tagging = {
  Environment = "sandbox"
  Project     = "DevOps"
  TfVersion   = "v1.11.4"
  Owner       = "admin@try-devops.xyz"
}
