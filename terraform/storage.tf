resource "digitalocean_spaces_bucket" "nixos" {
  name   = var.nixos_bucket
  region = "fra1"
  versioning { enabled = "true" }
  acl = "private"
}