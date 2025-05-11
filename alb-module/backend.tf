terraform {
  backend "s3" {
    bucket       = "gitops-demo-bucket-tf"
    key          = "testing/tfstate/terraform.tfstate"
    region       = "ap-south-1"
    profile      = "vault_admin"
    encrypt      = true
    use_lockfile = true
  }
}
