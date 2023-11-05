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

provider "digitalocean" {
  token = "null"
}

module "maxmorrisio" {
  source             = "../../terraform"
  cloudflare_token = "nullnullnullnullnullnullnullnullnullnull"
  cloudflare_account_id = "null"
  cloudflare_clancy_secret = "null"
  cloudflare_github_client_id = "null"
  cloudflare_github_client_secret = "null"
  cloudflare_zone_id = "nul"
}