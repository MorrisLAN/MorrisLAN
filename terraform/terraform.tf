terraform {
  cloud {
    organization = "morrislan"
    workspaces { name = "morrislan" }
  }
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    github = {
      source = "integrations/github"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "digitalocean" {
  token             = var.do_token
  spaces_access_id  = var.do_spaces_access_key
  spaces_secret_key = var.do_spaces_secret_key
}

provider "github" {}