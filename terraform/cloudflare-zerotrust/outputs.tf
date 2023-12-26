output "home_doh" {
  value     = cloudflare_teams_location.home.doh_subdomain
  sensitive = true
}

data "github_repository" "morrislan" {
  full_name = "MorrisLAN/morrislan"
}

resource "github_actions_organization_secret" "cfzt_home_tunnel_token" {
  secret_name             = "CFZT_HOME_TUNNEL_TOKEN"
  visibility              = "private"
  selected_repository_ids = [data.github_repository.morrislan]
  plaintext_value         = cloudflare_tunnel.home.tunnel_token
}