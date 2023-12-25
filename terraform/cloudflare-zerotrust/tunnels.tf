resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = "MorrisLAN"
  secret     = base64sha256(random_password.tunnel_secret.result)
  config_src = "cloudflare"
}

resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    warp_routing { enabled = true }
    ingress_rule {
      hostname = "status.morrislan.net"
      service  = "http://10.1.240.3:3001"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "ha.morrislan.net"
      service  = "https://10.1.240.3"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "unifi.morrislan.net"
      service  = "https://10.1.240.3:8443"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "access.morrislan.net"
      service  = "https://127.0.0.1"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "access.morrislan.net"
      service  = "tcp://127.0.0.1:3025"
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
