module "access_app_status" {
  source                = "m4xmorris/access-application/cloudflare"
  version               = "3.3.0"
  name                  = var.env == "prod" ? "Network Status" : "Network Status (${var.env})"
  logo                  = "https://static-00.iconduck.com/assets.00/uptime-kuma-icon-512x469-ce3ut52z.png"
  domain                = var.env == "prod" ? "status.morrislan.net" : "status-${var.env}.morrislan.net"
  type                  = "self_hosted"
  allowed_idps          = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible  = true
  session_duration      = "12h"
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token      = var.cloudflare_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  github_idp            = cloudflare_access_identity_provider.github.id
  github_org            = "MorrisLAN"
  gateway_device_rule_id = cloudflare_device_posture_rule.gateway.id
}

module "access_app_ha" {
  source                      = "m4xmorris/access-application/cloudflare"
  version                     = "3.3.0"
  name                        = var.env == "prod" ? "Home Assistant" : "Home Assistant (${var.env})"
  logo                        = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Home_Assistant_Logo.svg/2048px-Home_Assistant_Logo.svg.png"
  domain                      = var.env == "prod" ? "ha.morrislan.net" : "ha-${var.env}.morrislan.net"
  type                        = "self_hosted"
  allowed_idps                = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible        = true
  session_duration            = "2160h"
  cloudflare_account_id       = var.cloudflare_account_id
  cloudflare_token            = var.cloudflare_token
  cloudflare_zone_id          = var.cloudflare_zone_id
  github_idp                  = cloudflare_access_identity_provider.github.id
  github_org                  = "MorrisLAN"
  device_policy_rules_windows = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  device_policy_rules_macos   = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  device_policy_rules_ios     = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.os_version_ios.id]
  device_policy_rules_android = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.os_version_android.id]
  gateway_device_rule_id = cloudflare_device_posture_rule.gateway.id
}

module "access_app_unifi" {
  source                      = "m4xmorris/access-application/cloudflare"
  version                     = "3.3.0"
  name                        = var.env == "prod" ? "UniFi" : "UniFi (${var.env})"
  logo                        = "https://assets-global.website-files.com/622b70d8906c7ab0c03f77f8/63b40a92093c6b2f3767e4e6_tMCv8T-y_400x400.png"
  domain                      = var.env == "prod" ? "unifi.morrislan.net" : "unifi-${var.env}.morrislan.net"
  type                        = "self_hosted"
  allowed_idps                = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible        = true
  session_duration            = "12h"
  cloudflare_account_id       = var.cloudflare_account_id
  cloudflare_token            = var.cloudflare_token
  cloudflare_zone_id          = var.cloudflare_zone_id
  github_idp                  = cloudflare_access_identity_provider.github.id
  github_org                  = "MorrisLAN"
  github_teams                = ["Admins"]
  device_policy_rules_windows = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  device_policy_rules_macos   = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  gateway_device_rule_id = cloudflare_device_posture_rule.gateway.id
}

module "access_app_clancyadmin" {
  source                      = "m4xmorris/access-application/cloudflare"
  version                     = "3.3.0"
  name                        = var.env == "prod" ? "Clancy Admin" : "Clancy Admin (${var.env})"
  logo                        = "https://user-images.githubusercontent.com/23664304/36225509-be167464-117f-11e8-9bfc-cba7acd889c5.png"
  domain                      = var.env == "prod" ? "clancyadmin.morrislan.net" : "clancyadmin-${var.env}.morrislan.net"
  type                        = "self_hosted"
  allowed_idps                = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible        = true
  session_duration            = "12h"
  cloudflare_account_id       = var.cloudflare_account_id
  cloudflare_token            = var.cloudflare_token
  cloudflare_zone_id          = var.cloudflare_zone_id
  github_idp                  = cloudflare_access_identity_provider.github.id
  github_org                  = "MorrisLAN"
  github_teams                = ["Admins"]
  device_policy_rules_windows = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  device_policy_rules_macos   = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  gateway_device_rule_id = cloudflare_device_posture_rule.gateway.id
}

module "access_app_homeradmin" {
  source                      = "m4xmorris/access-application/cloudflare"
  version                     = "3.3.0"
  name                        = var.env == "prod" ? "Homer Admin" : "Homer Admin (${var.env})"
  logo                        = "https://tweakers.net/ext/i/2005515460.png"
  domain                      = var.env == "prod" ? "homeradmin.morrislan.net" : "homeradmin-${var.env}.morrislan.net"
  type                        = "self_hosted"
  allowed_idps                = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible        = true
  session_duration            = "12h"
  cloudflare_account_id       = var.cloudflare_account_id
  cloudflare_token            = var.cloudflare_token
  cloudflare_zone_id          = var.cloudflare_zone_id
  github_idp                  = cloudflare_access_identity_provider.github.id
  github_org                  = "MorrisLAN"
  github_teams                = ["Admins"]
  device_policy_rules_windows = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  device_policy_rules_macos   = [cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  gateway_device_rule_id = cloudflare_device_posture_rule.gateway.id
}
