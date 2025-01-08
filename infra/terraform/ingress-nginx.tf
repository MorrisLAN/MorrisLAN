resource "helm_release" "ingress_nginx" {
  depends_on       = [digitalocean_kubernetes_cluster.mgmt]
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version = "4.12.0"
  namespace        = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }
}