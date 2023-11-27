resource "cloudflare_device_settings_policy" "morrislan_settings" {
  account_id           = var.cloudflare_account_id
  name                 = "MorrisLAN WARP Profile"
  description          = "Default WARP profile for accessing MorrisLAN resources"
  default              = true
  enabled              = true
  captive_portal       = 5
  allow_mode_switch    = false
  switch_locked        = true
  allowed_to_leave     = true
  allow_updates        = true
  auto_connect         = 5
  service_mode_v2_mode = "warp"
  service_mode_v2_port = 3000
}