resource "cloudflare_access_application" "home_assistant" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Home Assistant"
  logo_url                  = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Home_Assistant_Logo.svg/2048px-Home_Assistant_Logo.svg.png"
  domain                    = "ha.morrislan.net"
  type                      = "self_hosted"
  allowed_idps              = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible      = true
  session_duration          = "2160h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "unifi" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "UniFi"
  logo_url                  = "https://assets-global.website-files.com/622b70d8906c7ab0c03f77f8/63b40a92093c6b2f3767e4e6_tMCv8T-y_400x400.png"
  domain                    = "unifi.morrislan.net"
  type                      = "self_hosted"
  allowed_idps              = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible      = true
  session_duration          = "12h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "homer_admin" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Homer Admin"
  logo_url                  = "https://tweakers.net/ext/i/2005515460.png"
  domain                    = "homer-admin.morrislan.net"
  type                      = "self_hosted"
  allowed_idps              = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible      = true
  session_duration          = "12h"
  auto_redirect_to_identity = false
}