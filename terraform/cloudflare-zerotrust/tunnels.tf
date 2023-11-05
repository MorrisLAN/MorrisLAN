resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = "clancy.morrislan.net"
  secret     = var.cloudflare_clancy_secret
  config_src = "cloudflare"
}
resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    ingress_rule {
      hostname = "ha.morrislan.net"
      service  = "https://ha.morrislan.net"
      origin_request {
        connect_timeout = "2m0s"
      }
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}