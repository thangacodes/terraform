resource "local_file" "tofu" {
  filename        = "${path.module}/tofu.txt"
  content         = "Welcome to OpenTofu! It's easiest to learn it!!!"
  file_permission = "0700"
}

resource "local_sensitive_file" "cred" {
  filename        = "${path.module}/dbcred.txt"
  content         = "dbadmin@1234"
  file_permission = "0700"
}

variable "greeting" {
  type        = string
  description = "It's just greetings to someone"
}

resource "local_file" "testing" {
  content  = "${var.greeting}, welcome to OpenTofu Learning!"
  filename = "${path.module}/hola2tofu.txt"
}