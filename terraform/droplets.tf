data "digitalocean_ssh_key" "morrislan" {
  id = "b3:57:07:56:0f:8b:88:eb:43:cd:f1:d7:38:59:a3:b5"
}

resource "digitalocean_droplet" "pcdo-ch-1" {
  image  = "161584796" # NixOS 24.05
  name   = "pcdo-ch-1"
  region = "lon1"
  size   = "s-2vcpu-2gb"
  backups = true
  ssh_keys = [ data.digitalocean_ssh_key.morrislan.id ]
  graceful_shutdown = true
}