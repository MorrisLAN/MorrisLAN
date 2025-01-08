resource "kubernetes_manifest" "namespace_hoopdev" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = "hoopdev"
    }
  }
}

resource "helm_release" "hoopdev" {
  depends_on       = [digitalocean_kubernetes_cluster.mgmt]
  name             = "hoopdev"
  chart            = "https://releases.hoop.dev/release/1.31.19/hoop-chart-1.31.19.tgz"
  namespace        = "hoopdev"
  create_namespace = true
  values = [
    <<EOT
config:
  API_URL: "https://hoop.morrislan.net"
  POSTGRES_DB_URI: "postgres://root:${var.hoopdev_db_pass}@hoopdev-db.hoopdev:5432/hoopdb?sslmode=disable"
  IDP_ISSUER: "https://auth.morrislan.net/application/o/hoopdev/"
  IDP_CLIENT_ID: ${var.hoopdev_oidc_id}
  IDP_CLIENT_SECRET: ${var.hoopdev_oidc_secret}
  notification:
    slackBotToken: ${var.hoopdev_slack_token}
ingressApi:
  enabled: true
  ingressClassName: nginx
  host: hoop.morrislan.net
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt"
  tls:
    - hosts:
      - hoop.morrislan.net
      secretName: hoopdev-web-tls
ingressGrpc:
  enabled: true
  ingressClassName: nginx
  host: hoop-grpc.morrislan.net
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt"
  tls:
    - hosts:
      - hoop-grpc.morrislan.net
      secretName: hoopdev-grpc-tls
defaultAgent:
  enabled: true
resources:
  gw:
    requests:
      memory: "512Mi"
persistence:
  enabled: true
  storageClassName: "do-block-storage"
EOT
  ]
}

resource "kubernetes_manifest" "hoopdev_db_pvc" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "PersistentVolumeClaim"
    "metadata" = {
      "name"      = "hoopdev-db"
      "namespace" = "hoopdev"
    }
    "spec" = {
      "accessModes" = ["ReadWriteOnce"]
      "resources" = {
        "requests" = {
          "storage" = "10Gi"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "hoopdev_db_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "hoopdev-db"
      "namespace" = "hoopdev"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "hoopdev-db"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "hoopdev-db"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name"  = "POSTGRES_USER"
                  "value" = "root"
                },
                {
                  "name"  = "POSTGRES_PASSWORD"
                  "value" = var.hoopdev_db_pass
                },
                {
                  "name"  = "POSTGRES_DB"
                  "value" = "hoopdb"
                }
              ]
              "image" = "postgres"
              "name"  = "postgres"
              "ports" = [
                {
                  "containerPort" = 5432
                  "name"          = "pg"
                  "protocol"      = "TCP"
                }
              ]
              "volumeMounts" = [
                {
                  "name"      = "pg-data"
                  "mountPath" = "/var/lib/postgresql/data"
                }
              ]
            }
          ]
          "volumes" = [
            {
              "name" = "pg-data"
              "persistentVolumeClaim" = {
                "claimName" = "hoopdev-db"
              }
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "hoopdev_db_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "name"      = "hoopdev-db"
      "namespace" = "hoopdev"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "postgres"
          "port"       = 5432
          "protocol"   = "TCP"
          "targetPort" = 5432
        }
      ]
      "selector" = {
        "app" = "hoopdev-db"
      }
    }
  }
}