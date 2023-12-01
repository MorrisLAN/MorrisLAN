output "tunnel_token" {
  value     = module.cloudflare-zerotrust.tunnel_token
  sensitive = true
}

output "home_doh" {
  value     = cloudflare_teams_location.home.doh_subdomain
  sensitive = true
}