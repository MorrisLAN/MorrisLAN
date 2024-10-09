resource "helm_release" "rancher" {
  name       = "rancher"
  repository = "https://charts.rancher.io/stable"
  chart      = "rancher"
  namespace  = "cattle-system"

  set {
    name  = "hostname"
    value = "rancher.morrislan.net"
  }

  depends_on = [digitalocean_kubernetes_cluster.vapor]
}
