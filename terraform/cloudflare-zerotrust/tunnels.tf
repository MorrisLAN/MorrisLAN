resource "cloudflare_tunnel" "home" {
  account_id = var.cloudflare_account_id
  name       = "Home Tunnel"
  secret     = base64sha256(random_password.tunnel_secret.result)
  config_src = "cloudflare"
}

resource "cloudflare_tunnel_config" "home" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.home.id
  config {
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
      hostname = "builds.morrislan.net"
      service  = "http://10.1.240.52:8080"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "srv-access-01-ssh.morrislan.net"
      service  = "ssh://127.0.0.1:4022"
      origin_request {
        connect_timeout = "2m0s"
      }
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}
