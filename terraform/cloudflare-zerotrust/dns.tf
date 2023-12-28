resource "cloudflare_record" "access_app_status" {
  zone_id         = var.cloudflare_zone_id
  name            = "status.morrislan.net"
  comment         = "CNAME to Home ZT Tunnel for Network Status page"
  value           = cloudflare_tunnel.home.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
}

resource "cloudflare_record" "access_app_ha" {
  zone_id         = var.cloudflare_zone_id
  name            = "ha.morrislan.net"
  comment         = "CNAME to Home ZT Tunnel for Home Assistant"
  value           = cloudflare_tunnel.home.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
}

resource "cloudflare_record" "access_app_unifi" {
  zone_id         = var.cloudflare_zone_id
  name            = "unifi.morrislan.net"
  comment         = "CNAME to Home ZT Tunnel for UniFi Controller"
  value           = cloudflare_tunnel.home.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
}

resource "cloudflare_record" "access_app_builds" {
  zone_id         = var.cloudflare_zone_id
  name            = "builds.morrislan.net"
  comment         = "CNAME to Home ZT Tunnel for CI/CD builds"
  value           = cloudflare_tunnel.home.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
}

resource "cloudflare_record" "access_app_srv_access_01_ssh" {
  zone_id         = var.cloudflare_zone_id
  name            = "srv-access-01-ssh.morrislan.net"
  comment         = "CNAME to Home ZT Tunnel for srv-access-01 SSH"
  value           = cloudflare_tunnel.home.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
}