resource "local_file" "tofu" {
  filename = "./tofu.txt"
  content  = "Welcome to OpenTofu! It's easiest to learn it!!!"
}
