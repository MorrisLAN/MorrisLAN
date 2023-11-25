module "cloudflare-zerotrust" {
  source                        = "./cloudflare-zerotrust"
  domain                        = var.domain
  cloudflare_token              = var.cloudflare_token
  cloudflare_account_id         = var.cloudflare_account_id
  access_tunnel_clancy_password = var.access_tunnel_clancy_password
  github_client_id              = var.gh_client_id
  github_client_secret          = var.gh_client_secret
  cloudflare_zone_id            = var.cloudflare_zone_id
}
