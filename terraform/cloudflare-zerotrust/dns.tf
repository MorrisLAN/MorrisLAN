resource "cloudflare_record" "status" {
  zone_id         = var.cloudflare_zone_id
  name            = "status.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "home_assistant" {
  zone_id         = var.cloudflare_zone_id
  name            = "ha.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "unifi" {
  zone_id         = var.cloudflare_zone_id
  name            = "unifi.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "clancy_admin" {
  zone_id         = var.cloudflare_zone_id
  name            = "clancy-admin.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "homer_admin" {
  zone_id         = var.cloudflare_zone_id
  name            = "homer-admin.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}