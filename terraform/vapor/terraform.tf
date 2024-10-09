terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "kubernetes" {
  config_path = "${path.module}/kubeconfig.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/kubeconfig.yaml"
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}