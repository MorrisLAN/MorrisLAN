output "home_doh" {
  value     = cloudflare_teams_location.home.doh_subdomain
  sensitive = true
}

resource "github_actions_secret" "cfzt_home_tunnel_token" {
  repository       = "morrislan"
  secret_name      = "CFZT_HOME_TUNNEL_TOKEN"
  plaintext_value  = cloudflare_tunnel.home.tunnel_token
}