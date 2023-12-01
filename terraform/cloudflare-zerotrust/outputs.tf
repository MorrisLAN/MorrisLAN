output "tunnel_token" {
  value     = cloudflare_tunnel.clancy.tunnel_token
  sensitive = true
}

output "home_doh" {
  value = cloudflare_teams_location.home.doh_subdomain
  sensitive = true
}