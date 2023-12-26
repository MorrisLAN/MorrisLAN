terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    github = {
      source = "integrations/github"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}