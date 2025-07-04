resource "aws_instance" "modvm" {
  ami                    = var.image_id
  instance_type          = var.vm_spec
  key_name               = var.keyname
  vpc_security_group_ids = var.sgp
  tags                   = var.tagging
}
