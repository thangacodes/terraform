resource "local_file" "tofu" {
  filename        = "./tofu.txt"
  content         = "Welcome to OpenTofu! It's easiest to learn it!!!"
  file_permission = "0700"
}

resource "local_sensitive_file" "cred" {
  filename        = "./dbpassword.txt"
  content         = "secrets"
  file_permission = "0700"
}
