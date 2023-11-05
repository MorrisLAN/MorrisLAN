resource "cloudflare_record" "home_assistant" {
  zone_id         = var.cloudflare_zone_id
  name            = "ha.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}