output "tunnel_token" {
  value     = module.cloudflare-zerotrust.tunnel_token
  sensitive = true
}

output "home_doh" {
  value     = module.cloudflare-zerotrust.home_doh
  sensitive = true
}