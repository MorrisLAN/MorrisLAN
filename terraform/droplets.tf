resource "digitalocean_droplet" "pcdo-ch-1" {
  image             = "161584796" # NixOS 24.05
  name              = "pcdo-ch-1"
  region            = "lon1"
  size              = "s-2vcpu-2gb"
  backups           = true
  ssh_keys          = [var.digitalocean_ssh_key]
  graceful_shutdown = true
}