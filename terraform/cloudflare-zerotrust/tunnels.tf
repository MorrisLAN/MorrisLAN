resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = "clancy.morrislan.net"
  secret     = base64sha256(random_password.tunnel_secret.result)
  config_src = "cloudflare"
}

resource "cloudflare_tunnel_virtual_network" "morrislan_cloud" {
  account_id         = var.cloudflare_account_id
  name               = "MorrisLAN-Cloud"
  comment            = "Default virtual network for accessing MorrisLAN resources"
  is_default_network = true
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
      hostname = "clancyadmin.morrislan.net"
      service  = "https://10.1.240.1:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "homeradmin.morrislan.net"
      service  = "https://10.1.240.2:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "clancyipmi.morrislan.net"
      service  = "https://10.1.240.12:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "homeripmi.morrislan.net"
      service  = "https://10.1.240.11:2053"
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