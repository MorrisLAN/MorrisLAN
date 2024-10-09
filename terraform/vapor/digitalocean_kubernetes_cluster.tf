resource "digitalocean_kubernetes_cluster" "vapor" {
  name    = "vapor"
  region  = "lon1"
  version = "1.31.1-do.2"
  node_pool {
    name       = "vapor-node"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}