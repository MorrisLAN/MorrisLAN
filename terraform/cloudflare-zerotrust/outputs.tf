output "home_doh" {
  value     = cloudflare_teams_location.home.doh_subdomain
  sensitive = true
}

resource "github_actions_secret" "cfzt_home_tunnel_token" {
  repository      = "morrislan"
  secret_name     = "CFZT_HOME_TUNNEL_TOKEN"
  plaintext_value = cloudflare_tunnel.home.tunnel_token
}

resource "github_actions_secret" "cfzt_home_mn_key" {
  repository      = "morrislan"
  secret_name     = "CFZT_HOME_MN_KEY"
  plaintext_value = base64encode(tls_private_key.cfzt_home.private_key_pem)
}

resource "github_actions_secret" "cfzt_home_mn_cert" {
  repository      = "morrislan"
  secret_name     = "CFZT_HOME_MN_CERT"
  plaintext_value = base64encode(tls_self_signed_cert.cfzt_home.cert_pem)
}