resource "digitalocean_kubernetes_cluster" "vapor" {
  name               = "vapor"
  region             = "lon1"
  version            = "latest"
  node_pool {
    name       = "nodes"
    size      = "s-2vcpu-2gb"
    node_count = 1
  }
}

resource "digitalocean_kubernetes_cluster_kube_config" "config" {
  cluster_id = digitalocean_kubernetes_cluster.vapor.id
}