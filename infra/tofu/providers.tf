terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    vultr = {
      source = "vultr/vultr"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    kubernetes = {
      source = "kubernetes"
    }
    helm = {
      source = "helm"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "vultr" {
  api_key = var.vultr_token
}  

provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.mgmt.endpoint
  token = digitalocean_kubernetes_cluster.mgmt.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.mgmt.kube_config[0].cluster_ca_certificate
  )
}


provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.mgmt.endpoint
    token = digitalocean_kubernetes_cluster.mgmt.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.mgmt.kube_config[0].cluster_ca_certificate
    )
  }
}