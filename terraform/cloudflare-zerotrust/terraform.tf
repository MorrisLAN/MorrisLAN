terraform {
  cloud {
    organization = "morrislan"
    workspaces { name = "cloudflare-zerotrust" }
  }
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}
