output "tunnel_token" {
  value     = module.cloudflare-zerotrust.cloudflare_tunnel.clancy.tunnel_token
  sensitive = true
}