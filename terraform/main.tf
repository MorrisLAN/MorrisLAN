module "cloudflare-zerotrust" {
  source                        = "./cloudflare-zerotrust"
  env                           = var.env
  cloudflare_token              = var.cloudflare_token
  cloudflare_account_id         = var.cloudflare_account_id
  access_tunnel_clancy_password = var.access_tunnel_clancy_password
  github_client_id              = var.gh_client_id
  github_client_secret          = var.gh_client_secret
  cloudflare_zone_id            = var.cloudflare_zone_id
}

resource "cloudflare_record" "github_verify" {
  count           = var.env == "prod" ? 1 : 0
  zone_id         = var.cloudflare_zone_id
  name            = "_github-challenge-MorrisLAN-org"
  comment         = "Domain ownership verification for GitHub"
  value           = "e2628155b4"
  allow_overwrite = true
  type            = "TXT"
}