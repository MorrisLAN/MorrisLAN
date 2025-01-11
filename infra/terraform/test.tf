resource "digitalocean_spaces_bucket" "bucket" {
  name   = "name-of-bucket"
  region = "fra1" # https://docs.digitalocean.com/products/spaces/details/availability/
  versioning {enabled = "true"}
  acl = "private"
}