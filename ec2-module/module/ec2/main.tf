resource "aws_instance" "fleetvm" {
  ami                    = var.ami-id
  key_name               = var.sshkey
  instance_type          = var.vmspec
  vpc_security_group_ids = var.sgp
  tags                   = var.tagging.default
}