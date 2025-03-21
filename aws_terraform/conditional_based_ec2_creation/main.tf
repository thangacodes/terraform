// Would like to create "3" instances dynamically using "count" is a meta-argument that can be used with resources, modules, and data sources.

resource "aws_instance" "demo_ec2" {
  ami                    = var.amiid
  count                  = var.create_ec2_instances ? var.instance_count : 0
  instance_type          = var.vmspec
  key_name               = var.sshkey
  vpc_security_group_ids = [var.sgp]
  tags = {
    Name = "ALT-INT-${count.index + 1}"
  }
}

resource "null_resource" "dummy-exec" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "sh ./simple.sh"
  }
}
