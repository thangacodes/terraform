resource "aws_instance" "vault" {
  ami                         = "ami-0305d3d91b9f22e84"
  instance_type               = "t3.medium"
  key_name                    = "ai"
  vpc_security_group_ids      = ["sg-0fb1052b659369aa8"]
  subnet_id                   = "subnet-03e0a14f"
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/vault_user_data.tpl", {
    node_id = "vault_node_a"
  })

  tags = {
    Name      = "Dev-VaultServer"
    CreatedBy = "Terraform-Automation"
    Owner     = "admin@try-devops.xyz"
    Project   = "Platform Engineering"
    TF_Version= "Terraform v1.13.5"
  }
}
