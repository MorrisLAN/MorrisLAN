# resource "digitalocean_spaces_bucket" "nixos" {
#   name   = "${var.nixos_bucket}-nixos"
#   region = "fra1"
#   versioning { enabled = "false" }
#   acl = "private"
# }
