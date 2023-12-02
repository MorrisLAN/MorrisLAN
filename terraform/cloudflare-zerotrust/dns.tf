resource "cloudflare_record" "access_app_status" {
  zone_id         = var.cloudflare_zone_id
  name            = "status.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for Network Status page"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "access_app_ha" {
  zone_id         = var.cloudflare_zone_id
  name            = "ha.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for Home Assistant"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "access_app_unifi" {
  zone_id         = var.cloudflare_zone_id
  name            = "unifi.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for UniFi Controller"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "access_app_clancyadmin" {
  zone_id         = var.cloudflare_zone_id
  name            = "clancyadmin.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for Clancy Admin"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "access_app_homeradmin" {
  zone_id         = var.cloudflare_zone_id
  name            = "homeradmin.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for Homer Admin"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "access_app_clancyipmi" {
  zone_id         = var.cloudflare_zone_id
  name            = "clancyipmi.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for Clancy IPMI"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "access_app_homeripmi" {
  zone_id         = var.cloudflare_zone_id
  name            = "homeripmi.morrislan.net"
  comment         = "CNAME to Clancy ZT Tunnel for Homer IPMI"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}