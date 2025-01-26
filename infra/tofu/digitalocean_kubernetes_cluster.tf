resource "digitalocean_kubernetes_cluster" "mgmt" {
  name    = "mgmt"
  region  = "lon1"
  version = "1.31.1-do.5"

  node_pool {
    name       = "mgmt-node"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}

resource "digitalocean_kubernetes_node_pool" "mgmt_metrics" {
  name       = "metrics-node"
  cluster_id = digitalocean_kubernetes_cluster.mgmt.id
  size       = "s-4vcpu-8gb"
  node_count = 2
  taint {
    key    = "workloadKind"
    value  = "metrics"
    effect = "NoSchedule"
  }
  labels = {
    workloadKind  = "metrics"
  }
}
