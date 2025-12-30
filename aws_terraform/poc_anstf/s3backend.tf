## Making S3 bucket as terraform backend. Since it's a POC
terraform {
  backend "s3" {
    bucket  = "testing-epa-application-bucket19112025"
    key     = "terraform/state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    profile = "personal"
  }
}
