resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = var.env == "prod" ? "clancy.morrislan.net" : "clancy-${var.env}.morrislan.net"
  secret     = base64sha256(random_password.tunnel_secret.result)
  config_src = "cloudflare"
}

resource "cloudflare_tunnel_virtual_network" "morrislan_cloud" {
  account_id         = var.cloudflare_account_id
  name               = var.env == "prod" ? "MorrisLAN-Cloud" : "MorrisLAN-Cloud-${var.env}"
  comment            = "Default virtual network for accessing MorrisLAN resources"
  is_default_network = true
}

resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    ingress_rule {
      hostname = var.env == "prod" ? "status.morrislan.net" : "status-${var.env}.morrislan.net"
      service  = "http://10.1.240.3:3001"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "ha.morrislan.net" : "ha-${var.env}.morrislan.net"
      service  = "https://10.1.240.3"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "unifi.morrislan.net" : "unifi-${var.env}.morrislan.net"
      service  = "https://10.1.240.3:8443"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "clancyadmin.morrislan.net" : "clancyadmin-${var.env}.morrislan.net"
      service  = "https://10.1.240.1:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "homeradmin.morrislan.net" : "homeradmin-${var.env}.morrislan.net"
      service  = "https://10.1.240.2:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "clancyipmi.morrislan.net" : "clancyipmi-${var.env}.morrislan.net"
      service  = "https://10.1.240.12:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "homeripmi.morrislan.net" : "homeripmi-${var.env}.morrislan.net"
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