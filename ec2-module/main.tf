module "ec2" {
  source = "./module/ec2"
  ami-id = "ami-0f1dcc636b69a6438"
  sshkey = "mac"
  vmspec = "t2.micro"
  sgp    = ["sg-0fb1052b659369aa8"]
  tagging = {
    default = {
      Name         = "Monolithic Server"
      Project      = "App-Deployment"
      CreationDate = "29/04/2025"
      TFVersion    = "1.10.0"
    }
  }
}