terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "cloudflare" {
  api_token = "nullnullnullnullnullnullnullnullnullnull"
}

module "cloudflare-zerotrust" {
  source                          = "../../terraform/cloudflare-zerotrust"
  cloudflare_token                = "nullnullnullnullnullnullnullnullnullnull"
  cloudflare_account_id           = "null"
  access_tunnel_clancy_password   = "l2BnR/sz3/FztVJW9szhglQRy93naSBWt0c3XrU3nEF7zFg+6m4lg5D5/8F2Ov6K"
  github_client_id     = "null"
  github_client_secret = "null"
  cloudflare_zone_id              = "nul"
}