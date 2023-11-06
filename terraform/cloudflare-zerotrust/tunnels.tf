resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = "clancy.morrislan.net"
  secret     = var.access_tunnel_clancy_secret
  config_src = "cloudflare"
}
resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    ingress_rule {
      hostname = "status.morrislan.net"
      service  = "http://marge.morrislan.net:3001"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "ha.morrislan.net"
      service  = "https://ha.morrislan.net"
      origin_request {
        connect_timeout = "2m0s"
      }
    }
    ingress_rule {
      hostname = "unifi.morrislan.net"
      service  = "https://marge.morrislan.net:8443"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "clancyadmin.morrislan.net"
      service  = "https://clancy.morrislan.net:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "homeradmin.morrislan.net"
      service  = "https://homer.morrislan.net:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}