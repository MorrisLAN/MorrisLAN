resource "cloudflare_access_policy" "allow_home_assistant" {
  application_id = cloudflare_access_application.home_assistant.id
  zone_id        = var.cloudflare_zone_id
  name           = "Home Assistant Policy"
  precedence     = "1"
  decision       = "allow"
  dynamic "include" {
    for_each = var.allow_home_assistant_list
    content {
      email = include.value.email

      github {
        name                 = include.value.github.name
        identity_provider_id = cloudflare_access_identity_provider.github.id
      }
    }
  }
}

resource "cloudflare_access_policy" "allow_unifi" {
  application_id = cloudflare_access_application.unifi.id
  zone_id        = var.cloudflare_zone_id
  name           = "UniFi Policy"
  precedence     = "1"
  decision       = "allow"
  dynamic "include" {
    for_each = var.allow_unifi_list
    content {
      email = include.value.email

      github {
        name                 = include.value.github.name
        identity_provider_id = cloudflare_access_identity_provider.github.id
      }
    }
  }
}

resource "cloudflare_access_policy" "allow_homer_admin" {
  application_id = cloudflare_access_application.homer_admin.id
  zone_id        = var.cloudflare_zone_id
  name           = "Homer Admin Policy"
  precedence     = "1"
  decision       = "allow"
  dynamic "include" {
    for_each = var.allow_homer_admin_list
    content {
      email = include.value.email

      github {
        name                 = include.value.github.name
        identity_provider_id = cloudflare_access_identity_provider.github.id
      }
    }
  }
}