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

module "maxmorrisio" {
  source             = "../../terraform"
  cloudflare_token = "nullnullnullnullnullnullnullnullnullnull"
  cloudflare_account_id = "null"
  cloudflare_clancy_secret = "null"
  cloudflare_github_client_id = "null"
  cloudflare_github_client_secret = "null"
  cloudflare_zone_id = "nul"
  allow_home_assistant_list = [
    {
      email = ["null@example.com"]
      github = {
        name = "Null"
      }
    }
  ]
}