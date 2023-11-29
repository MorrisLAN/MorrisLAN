resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = var.env == "prod" ? "clancy.morrislan.net" : "clancy-${var.env}.morrislan.net"
  secret     = var.access_tunnel_clancy_password
  config_src = "cloudflare"
}

resource "cloudflare_tunnel_virtual_network" "morrislan_cloud" {
  account_id         = var.cloudflare_account_id
  name               = var.env == "prod" ? "MorrisLAN-Cloud" : "MorrisLAN-Cloud-${var.env}"
  comment            = "Default virtual network for accessing MorrisLAN resources"
  is_default_network = true
}

resource "cloudflare_tunnel_route" "morrislan" {
  account_id         = var.cloudflare_account_id
  tunnel_id          = cloudflare_tunnel.clancy.id
  virtual_network_id = cloudflare_tunnel_virtual_network.morrislan_cloud.id
  network            = "10.1.240.0/24"
  comment            = var.env == "prod" ? "MorrisLAN" : "MorrisLAN-${var.env}"
}

resource "cloudflare_tunnel_route" "morrislan_iot" {
  account_id         = var.cloudflare_account_id
  tunnel_id          = cloudflare_tunnel.clancy.id
  virtual_network_id = cloudflare_tunnel_virtual_network.morrislan_cloud.id
  network            = "10.1.241.0/24"
  comment            = var.env == "prod" ? "MorrisLAN-IOT" : "MorrisLAN-IOT-${var.env}"
}

resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    ingress_rule {
      hostname = var.env == "prod" ? "status.morrislan.net" : "status-${var.env}.morrislan.net"
      service  = "http://marge.morrislan.net:3001"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "ha.morrislan.net" : "ha-${var.env}.morrislan.net"
      service  = "https://ha.morrislan.net"
      origin_request {
        connect_timeout = "2m0s"
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "unifi.morrislan.net" : "unifi-${var.env}.morrislan.net"
      service  = "https://marge.morrislan.net:8443"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "clancyadmin.morrislan.net" : "clancyadmin-${var.env}.morrislan.net"
      service  = "https://clancy.morrislan.net:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = var.env == "prod" ? "homeradmin.morrislan.net" : "homeradmin-${var.env}.morrislan.net"
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