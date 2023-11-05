resource "cloudflare_access_identity_provider" "github" {
  account_id = var.cloudflare_account_id
  name       = "GitHub"
  type       = "github"
  config {
    client_id     = var.cloudflare_github_client_id
    client_secret = var.cloudflare_github_client_secret
  }
}

resource "cloudflare_access_identity_provider" "otp" {
  account_id = var.cloudflare_account_id
  name       = "OTP"
  type       = "onetimepin"
}

resource "cloudflare_access_application" "home_assistant" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Home Assistant"
  logo_url                  = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Home_Assistant_Logo.svg/2048px-Home_Assistant_Logo.svg.png"
  domain                    = "ha.morrislan.net"
  type                      = "self_hosted"
  allowed_idps              = [cloudflare_access_identity_provider.github.id, cloudflare_access_identity_provider.otp.id]
  app_launcher_visible      = true
  session_duration          = "2160h"
  auto_redirect_to_identity = false
}

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

resource "cloudflare_tunnel" "clancy" {
  account_id = var.cloudflare_account_id
  name       = "clancy.morrislan.net"
  secret     = var.cloudflare_clancy_secret
  config_src = "cloudflare"
}

output "clancy_token" {
  value     = cloudflare_tunnel.clancy.tunnel_token
  sensitive = true
}

resource "cloudflare_record" "home_assistant" {
  zone_id         = var.cloudflare_zone_id
  name            = "ha.morrislan.net"
  value           = cloudflare_tunnel.clancy.cname
  allow_overwrite = true
  type            = "CNAME"
  proxied         = true
  depends_on      = [cloudflare_tunnel.clancy]
}

resource "cloudflare_tunnel_config" "clancy" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.clancy.id
  config {
    ingress_rule {
      hostname = "ha.morrislan.net"
      service  = "https://ha.morrislan.net"
      origin_request {
        connect_timeout = "2m0s"
      }
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}
