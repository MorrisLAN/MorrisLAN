resource "cloudflare_record" "github_verify" {
  zone_id         = var.cloudflare_zone_id
  name            = "_github-challenge-MorrisLAN-org.morrislan.net"
  comment         = "Domain ownership verification for GitHub"
  content           = "e2628155b4"
  allow_overwrite = true
  type            = "TXT"
}

resource "cloudflare_record" "smtpgo_1" {
  zone_id         = var.cloudflare_zone_id
  name            = "em569112.morrislan.net"
  value           = "return.smtp2go.net"
  allow_overwrite = true
  type            = "CNAME"
}

resource "cloudflare_record" "smtpgo_2" {
  zone_id         = var.cloudflare_zone_id
  name            = "email-track.morrislan.net"
  value           = "track.smtp2go.net"
  allow_overwrite = true
  type            = "CNAME"
}

resource "cloudflare_record" "smtpgo_3" {
  zone_id         = var.cloudflare_zone_id
  name            = "s569112._domainkey.morrislan.net"
  value           = "dkim.smtp2go.net"
  allow_overwrite = true
  type            = "CNAME"
}