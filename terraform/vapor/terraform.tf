terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.vapor.endpoint
  token = digitalocean_kubernetes_cluster.vapor.kube_config[0].token
  cluster_ca_certificate = base64decode(
    ddigitalocean_kubernetes_cluster.vapor.kube_config[0].cluster_ca_certificate
  )
}


provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.vapor.endpoint
    token = digitalocean_kubernetes_cluster.vapor.kube_config[0].token
    cluster_ca_certificate = base64decode(
      ddigitalocean_kubernetes_cluster.vapor.kube_config[0].cluster_ca_certificate
    }
}

provider "digitalocean" {
  token = var.digitalocean_token
}