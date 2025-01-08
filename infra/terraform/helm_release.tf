resource "helm_release" "gitlab" {
  depends_on = [digitalocean_kubernetes_cluster.mgmt]
  name       = "gitlab"
  repository = "http://charts.gitlab.io/"
  chart      = "gitlab"
  version    = "8.7.3"

  namespace = "gitlab"

  create_namespace = true

  set {
    name  = "global.hosts.domain"
    value = "gitlab.morrislan.net"
  }
  set {
    name  = "certmanager.install"
    value = "false"
  }
  set {
    name  = "certmanager.installCRDs"
    value = "false"
  }
  set {
    name  = "nginx-ingress.enabled"
    value = "false"
  }
  set {
    name  = "certmanager-issuer.email"
    value = "ssl@morrislan.net"
  }
}