resource "cloudflare_device_settings_policy" "remote" {
  account_id        = var.cloudflare_account_id
  name              = "Remote Profile"
  description       = "Remote WARP profile for accessing MorrisLAN resources"
  default           = true
  enabled           = true
  allow_mode_switch = false
  switch_locked     = false
  allowed_to_leave  = true
  allow_updates     = false
  auto_connect      = 900
}

resource "cloudflare_device_settings_policy" "home" {
  account_id        = var.cloudflare_account_id
  name              = "Home Profile"
  description       = "Home WARP profile for accessing MorrisLAN resources"
  precedence        = 1
  match             = "network == \"Home\""
  enabled           = true
  allow_mode_switch = false
  switch_locked     = false
  allowed_to_leave  = true
  allow_updates     = true
  auto_connect      = 900
}
