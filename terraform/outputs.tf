output "tunnel_token" {
  value     = module.cloudflare-zerotrust.tunnel_token
  sensitive = true
}