resource "digitalocean_spaces_bucket" "test" {
  name   = "${var.nixos_bucket}-test"
  region = "fra1"
  versioning { enabled = "false" }
  acl = "private"
}
