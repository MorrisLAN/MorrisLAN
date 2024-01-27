resource "cloudflare_device_settings_policy" "default" {
  account_id        = var.cloudflare_account_id
  name              = "Default"
  description       = "Default WARP profile for accessing MorrisLAN resources"
  default           = true
  enabled           = true
  allow_mode_switch = false
  switch_locked     = false
  allowed_to_leave  = true
  allow_updates     = true
  auto_connect      = 2700
}

resource "cloudflare_split_tunnel" "cloudflare" {
  account_id = var.cloudflare_account_id
  policy_id  = cloudflare_device_settings_policy.default.id
  mode       = "include"
  tunnels {
    host        = "*.cloudflare.com"
    description = "Cloudflare"
  }
}

resource "cloudflare_split_tunnel" "cloudflare_access" {
  account_id = var.cloudflare_account_id
  policy_id  = cloudflare_device_settings_policy.default.id
  mode       = "include"
  tunnels {
    host        = "*.cloudflareaccess.com"
    description = "Cloudflare Access"
  }
}

resource "cloudflare_split_tunnel" "morrislan" {
  account_id = var.cloudflare_account_id
  policy_id  = cloudflare_device_settings_policy.default.id
  mode       = "include"
  tunnels {
    host        = "*.morrislan.net"
    description = "MorrisLAN"
  }
}
