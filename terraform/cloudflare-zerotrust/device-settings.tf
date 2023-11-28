resource "cloudflare_device_settings_policy" "morrislan_settings" {
  account_id           = var.cloudflare_account_id
  name                 = var.env == "prod" ? "MorrisLAN WARP Profile" : "MorrisLAN WARP Profile (${var.env})"
  description          = "Default WARP profile for accessing MorrisLAN resources"
  default              = true
  enabled              = true
  allow_mode_switch    = false
  switch_locked        = true
  allowed_to_leave     = false
  allow_updates        = true
  auto_connect         = 120
  service_mode_v2_mode = "warp"
  service_mode_v2_port = 3000
}

resource "cloudflare_device_settings_policy" "home_settings" {
  account_id           = var.cloudflare_account_id
  name                 = "On Home Network (Disabled)"
  description          = "Connected to Home Network - Posture Checks Only"
  precedence           = 10
  match                = "network == Home"
  enabled              = true
  allow_mode_switch    = true
  switch_locked        = true
  allowed_to_leave     = true
  allow_updates        = true
  auto_connect         = 300
  service_mode_v2_mode = "posture_only"
  service_mode_v2_port = 3000
}