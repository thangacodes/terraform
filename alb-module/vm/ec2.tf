resource "aws_instance" "web-vm" {
  ami                    = var.amiid
  instance_type          = var.vmspec
  count                  = var.instance_count
  key_name               = var.key
  vpc_security_group_ids = var.sgp
  user_data              = file("${path.module}/init_script.sh")
  tags                   = merge(var.tagging, { Name = "Web-Server-${count.index + 1}" })
}