resource "cloudflare_access_policy" "gateway_policy_status" {
  application_id                 = module.cloudflare-zerotrust.module.access_app_status.cloudflare_access_application.application
  zone_id                        = var.cloudflare_zone_id
  name                           = "Network Status Gateway Policy"
  precedence                     = "6"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.gateway.id]
  }
}

resource "cloudflare_access_policy" "gateway_policy_ha" {
  application_id                 = module.cloudflare-zerotrust.module.access_app_ha.cloudflare_access_application.application
  zone_id                        = var.cloudflare_zone_id
  name                           = "Home Assistant Gateway Policy"
  precedence                     = "6"
  decision                       = "allow"
  include {
    device_posture = [cloudflare_device_posture_rule.gateway.id]
  }
}