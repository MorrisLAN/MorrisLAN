resource "helm_release" "hoopdev" {
  depends_on = [digitalocean_kubernetes_cluster.mgmt]
  name       = "hoopdev"
  chart      = "https://releases.hoop.dev/release/1.31.19/hoop-chart-1.31.19.tgz"

  namespace = "hoopdev"

  create_namespace = true

  set {
    name  = "config.API_URL"
    value = "https://hoopdev.morrislan.net"
  }
  set {
    name  = "config.POSTGRES_DB_URI"
    value = "postgres://root:${var.hoopdev_db_pass}@hoopdev-db.hoopdev:5432/hoopdb?sslmode=disable"
  }
  set {
    name  = "config.IDP_ISSUER"
    value = "https://auth.morrislan.net/application/o/hoopdev/"
  }
  set {
    name  = "config.IDP_CLIENT_ID"
    value = var.hoopdev_oidc_id
  }
  set {
    name  = "config.IDP_CLIENT_SECRET"
    value = var.hoopdev_oidc_secret
  }
  set {
    name  = "defaultAgent.enabled"
    value = "true"
  }
  set {
    name  = "resources.gw.requests.memory"
    value = "512Mi"
  }
}

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