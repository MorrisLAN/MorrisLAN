module "access_app_unifi" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "2.0.1"
  name                  = "UniFi"
  logo                  = "https://assets-global.website-files.com/622b70d8906c7ab0c03f77f8/63b40a92093c6b2f3767e4e6_tMCv8T-y_400x400.png"
  domain                = "unifi.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "12h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  github_idp            = cloudflare_access_identity_provider.github.id
  github_org            = "MorrisLAN"
  github_teams          = ["Admins"]
  allowed_emails        = []
}

module "access_app_clancyadmin" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "2.0.1"
  name                  = "Clancy Admin"
  logo                  = "https://user-images.githubusercontent.com/23664304/36225509-be167464-117f-11e8-9bfc-cba7acd889c5.png"
  domain                = "clancyadmin.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "12h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  github_idp            = cloudflare_access_identity_provider.github.id
  github_org            = "MorrisLAN"
  github_teams          = ["Admins"]
  allowed_emails        = []
}

module "access_app_homeradmin" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "2.0.1"
  name                  = "Homer Admin"
  logo                  = "https://tweakers.net/ext/i/2005515460.png"
  domain                = "homeradmin.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "12h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  github_idp            = cloudflare_access_identity_provider.github.id
  github_org            = "MorrisLAN"
  github_teams          = ["Admins"]
  allowed_emails        = []
}
