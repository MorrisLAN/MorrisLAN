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
    name  = "config.notification.slackBotToken"
    value = var.hoopdev_slack_token
  }
  set {
    name  = "defaultAgent.enabled"
    value = "true"
  }
  set {
    name  = "resources.gw.requests.memory"
    value = "512Mi"
  }
  set {
    name  = "persistence.enabled"
    value = "true"
  }
  set {
    name  = "persistence.storageClassName"
    value = "do-block-storage"
  }
}