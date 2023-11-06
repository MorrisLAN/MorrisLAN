resource "cloudflare_record" "status" {
  zone_id         = var.cloudflare_zone_id
  name            = "status.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "ha" {
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

resource "cloudflare_record" "clancyadmin" {
  zone_id         = var.cloudflare_zone_id
  name            = "clancyadmin.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_record" "homeradmin" {
  zone_id         = var.cloudflare_zone_id
  name            = "homeradmin.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}