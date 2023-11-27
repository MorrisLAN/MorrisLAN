resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = "clancy-${var.env}.morrislan.net"
  secret     = var.access_tunnel_clancy_password
  config_src = "cloudflare"
}

resource "cloudflare_tunnel_virtual_network" "morrislan_cloud" {
  account_id         = var.cloudflare_account_id
  name               = "MorrisLAN-Cloud"
  comment            = "Default virtual network for accessing MorrisLAN resources"
  is_default_network = true
}

resource "cloudflare_tunnel_route" "morrislan" {
  account_id         = var.cloudflare_account_id
  tunnel_id          = cloudflare_tunnel.clancy.id
  virtual_network_id = cloudflare.cloudflare_tunnel_virtual_network.morrislan_cloud.id
  network            = "10.1.240.0/24"
  comment            = "MorrisLAN"
}

resource "cloudflare_tunnel_route" "morrislan_iot" {
  account_id         = var.cloudflare_account_id
  tunnel_id          = cloudflare_tunnel.clancy.id
  virtual_network_id = cloudflare.cloudflare_tunnel_virtual_network.morrislan_cloud.id
  network            = "10.1.241.0/24"
  comment            = "MorrisLAN-IOT"
}

resource "cloudflare_split_tunnel" "morrislan" {
  account_id = var.cloudflare_account_id
  mode       = "include"
  tunnels {
    address     = "10.1.240.0/24"
    description = "MorrisLAN"
  }
}

resource "cloudflare_split_tunnel" "morrislan_iot" {
  account_id = var.cloudflare_account_id
  mode       = "include"
  tunnels {
    address     = "10.1.241.0/24"
    description = "MorrisLAN-IOT"
  }
}

resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    ingress_rule {
      hostname = "status-${var.env}.morrislan.net"
      service  = "http://marge.morrislan.net:3001"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "ha-${var.env}.morrislan.net"
      service  = "https://ha.morrislan.net"
      origin_request {
        connect_timeout = "2m0s"
      }
    }
    ingress_rule {
      hostname = "unifi-${var.env}.morrislan.net"
      service  = "https://marge.morrislan.net:8443"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "clancyadmin-${var.env}.morrislan.net"
      service  = "https://clancy.morrislan.net:2053"
      origin_request {
        connect_timeout = "2m0s"
        no_tls_verify   = true
      }
    }
    ingress_rule {
      hostname = "homeradmin-${var.env}.morrislan.net"
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