resource "digitalocean_spaces_bucket" "nixos" {
  name   = "morrislan-nixos-images"
  region = "fra1"
  versioning { enabled = "true" }
  acl = "private"
}