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
  source             = "../../terraform/cloudflare-zerotrust"
  cloudflare_token = "nullnullnullnullnullnullnullnullnullnull"
  cloudflare_account_id = "null"
  cloudflare_clancy_secret = "l2BnR/sz3/FztVJW9szhglQRy93naSBWt0c3XrU3nEF7zFg+6m4lg5D5/8F2Ov6K"
  cloudflare_github_client_id = "null"
  cloudflare_github_client_secret = "null"
  cloudflare_zone_id = "nul"
  allow_status_list = [
    {
      email = ["null@example.com"]
      github = {
        name = "Null"
      }
    }
  ]
  allow_home_assistant_list = [
    {
      email = ["null@example.com"]
      github = {
        name = "Null"
      }
    }
  ]
  allow_unifi_list = [
    {
      email = ["null@example.com"]
      github = {
        name = "Null"
      }
    }
  ]
  allow_clancy_admin_list = [
    {
      email = ["null@example.com"]
      github = {
        name = "Null"
      }
    }
  ]
  allow_homer_admin_list = [
    {
      email = ["null@example.com"]
      github = {
        name = "Null"
      }
    }
  ]
}