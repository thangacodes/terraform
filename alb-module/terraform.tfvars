region         = "ap-south-1"
profile        = "vault_admin"
amiid          = "ami-062f0cc54dbfd8ef1"
vmspec         = "t2.micro"
instance_count = 2
key            = "bastion"
sgp            = ["sg-0fb1052b659369aa8"]
tagging = {
  Environment = "sandbox"
  Project     = "DevOps"
  TfVersion   = "v1.11.4"
  Owner       = "admin@try-devops.xyz"
}