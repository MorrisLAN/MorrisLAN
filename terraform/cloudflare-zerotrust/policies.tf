resource "cloudflare_access_policy" "device_policy_windows_ha" {
  application_id                 = module.access_app_ha.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Home Assistant Device Policy (Windows)"
  precedence                     = "1"
  decision                       = "non_identity"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_windows.id]
  }
  require {
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  }
}

resource "cloudflare_access_policy" "device_policy_macos_ha" {
  application_id                 = module.access_app_ha.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Home Assistant Device Policy (macOS)"
  precedence                     = "2"
  decision                       = "non_identity"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_macos.id]
  }
  require {
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  }
}

resource "cloudflare_access_policy" "device_policy_ios_ha" {
  application_id                 = module.access_app_ha.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Home Assistant Device Policy (iOS)"
  precedence                     = "3"
  decision                       = "non_identity"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_ios.id]
  }
  require {
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.os_version_ios.id]
  }
}

resource "cloudflare_access_policy" "device_policy_android_ha" {
  application_id                 = module.access_app_ha.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Home Assistant Device Policy (Android)"
  precedence                     = "4"
  decision                       = "non_identity"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_android.id]
  }
  require {
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.os_version_android.id]
  }
}

resource "cloudflare_access_policy" "device_policy_windows_unifi" {
  application_id                 = module.access_app_unifi.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "UniFi Device Policy (Windows)"
  precedence                     = "1"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_windows.id]
  }
  require {
    github {
      name                 = "MorrisLAN"
      identity_provider_id = cloudflare_access_identity_provider.github.id
      teams                = ["Admins"]
    }
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  }
}

resource "cloudflare_access_policy" "device_policy_macos_unifi" {
  application_id                 = module.access_app_unifi.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "UniFi Device Policy (macOS)"
  precedence                     = "2"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_macos.id]
  }
  require {
    github {
      name                 = "MorrisLAN"
      identity_provider_id = cloudflare_access_identity_provider.github.id
      teams                = ["Admins"]
    }
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  }
}

resource "cloudflare_access_policy" "device_policy_windows_homeradmin" {
  application_id                 = module.access_app_homeradmin.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Homer Admin Device Policy (Windows)"
  precedence                     = "1"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_windows.id]
  }
  require {
    github {
      name                 = "MorrisLAN"
      identity_provider_id = cloudflare_access_identity_provider.github.id
      teams                = ["Admins"]
    }
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  }
}

resource "cloudflare_access_policy" "device_policy_macos_homeradmin" {
  application_id                 = module.access_app_homeradmin.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Homer Admin Device Policy (macOS)"
  precedence                     = "2"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_macos.id]
  }
  require {
    github {
      name                 = "MorrisLAN"
      identity_provider_id = cloudflare_access_identity_provider.github.id
      teams                = ["Admins"]
    }
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  }
}

resource "cloudflare_access_policy" "device_policy_windows_clancyadmin" {
  application_id                 = module.access_app_clancyadmin.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Clancy Admin Device Policy (Windows)"
  precedence                     = "1"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_windows.id]
  }
  require {
    github {
      name                 = "MorrisLAN"
      identity_provider_id = cloudflare_access_identity_provider.github.id
      teams                = ["Admins"]
    }
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_windows.id, cloudflare_device_posture_rule.disk_encryption_windows.id, cloudflare_device_posture_rule.os_version_windows.id]
  }
}

resource "cloudflare_access_policy" "device_policy_macos_clancyadmin" {
  application_id                 = module.access_app_clancyadmin.cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "Clancy Admin Device Policy (macOS)"
  precedence                     = "2"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.os_version_macos.id]
  }
  require {
    github {
      name                 = "MorrisLAN"
      identity_provider_id = cloudflare_access_identity_provider.github.id
      teams                = ["Admins"]
    }
    device_posture = [cloudflare_device_posture_rule.gateway.id, cloudflare_device_posture_rule.warp.id, cloudflare_device_posture_rule.firewall_macos.id, cloudflare_device_posture_rule.disk_encryption_macos.id, cloudflare_device_posture_rule.os_version_macos.id]
  }
}