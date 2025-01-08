resource "digitalocean_kubernetes_cluster" "mgmt" {
  name   = "mgmt"
  region = "lon1"
  version = "1.31.1-do.5"

  node_pool {
    name       = "mgmt"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}