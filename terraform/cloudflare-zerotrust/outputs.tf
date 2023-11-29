output "tunnel_token" {
  value     = cloudflare_tunnel.clancy.tunnel_token
  sensitive = true
}