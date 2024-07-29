data "digitalocean_ssh_key" "onepassword" {
  name = "1Password"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjgkh0LyGVjWzYnCxrKC5dxQMHE3ky7s/vFpAyjfk5l"
}

resource "digitalocean_droplet" "pcdo-ch-1" {
  image  = "161584796" # NixOS 24.05
  name   = "pcdo-ch-1"
  region = "lon1"
  size   = "s-2vcpu-2gb"
  backups = true
  ssh_keys = [ data.digitalocean_ssh_key.onepassword.id ]
  graceful_shutdown = true
}