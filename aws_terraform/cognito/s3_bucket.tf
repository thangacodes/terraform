terraform {
  backend "s3" {
    bucket = "testing-epa-application-bucket19112025"
    key    = "cognito-setup/terraform.tfstate"
    region = "ap-south-1"
  }
}
