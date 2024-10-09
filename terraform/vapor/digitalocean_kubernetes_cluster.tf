resource "digitalocean_kubernetes_cluster" "vapor" {
  name    = "vapor"
  region  = "lon1"
  version = "latest"
  node_pool {
    name       = "vapor-nodes"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}