module "access_app_status" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "3.2.0"
  name                  = "MorrisLAN Status"
  logo                  = "https://static-00.iconduck.com/assets.00/uptime-kuma-icon-512x469-ce3ut52z.png"
  domain                = "status.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "2160h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  github_idp            = cloudflare_access_identity_provider.github.id
  github_org            = "MorrisLAN"
}

module "access_app_ha" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "3.2.0"
  name                  = "Home Assistant"
  logo                  = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Home_Assistant_Logo.svg/2048px-Home_Assistant_Logo.svg.png"
  domain                = "ha.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "2160h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  enable_managed_policy = false
}

module "access_app_unifi" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "3.2.0"
  name                  = "UniFi"
  logo                  = "https://assets-global.website-files.com/622b70d8906c7ab0c03f77f8/63b40a92093c6b2f3767e4e6_tMCv8T-y_400x400.png"
  domain                = "unifi.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "6h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  enable_managed_policy = false
}

module "access_app_builds" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "3.2.0"
  name                  = "CI/CD Builds"
  logo                  = "https://cdn-icons-png.flaticon.com/512/569/569220.png"
  domain                = "builds.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "2h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  enable_managed_policy = false
}

module "access_app_srv_access_01_ssh" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "3.2.0"
  name                  = "srv-access-01 SSH"
  logo                  = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Terminalicon2.png/768px-Terminalicon2.png"
  domain                = "srv-access-01-ssh.morrislan.net"
  type                  = "ssh"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "0h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  enable_managed_policy = false
}
