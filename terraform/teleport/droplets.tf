resource "digitalocean_droplet" "access" {
  image      = "ubuntu-22-04-x64"
  name       = "access.morrislan.net"
  region     = "lon1"
  size       = "s-1vcpu-1gb"
  monitoring = true
  backups    = true
  user_data = templatefile(
    "./teleport/setup-teleport.tpl",
    {
      gh_client_id       = var.gh_client_id
      gh_client_secret   = var.gh_client_secret
      dovpc_tunnel_token = var.dovpc_tunnel_token
    }
  )
}

resource "digitalocean_firewall" "access" {
  name        = "cfzt-ingress"
  droplet_ids = [digitalocean_droplet.access.id]
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}