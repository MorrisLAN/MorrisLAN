resource "kubernetes_manifest" "namespace_hoopdev" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = "hoopdev"
    }
  }
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

resource "kubernetes_manifest" "namespace_cloudflare_access" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = "cloudflare-access"
    }
  }
}

resource "kubernetes_manifest" "cloudflare_access_daemonset" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "DaemonSet"
    "metadata" = {
      "name"      = "cloudflare-access"
      "namespace" = "cloudflare-access"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "cloudflare-access"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "cloudflare-access"
          }
        }
        "spec" = {
          "containers" = [
            {
              "name"  = "cloudflared"
              "image" = "cloudflare/cloudflared:2024.10.0"
              "args"  = ["tunnel", "run"]
              "env" = [
                {
                  "name"  = "TUNNEL_TOKEN"
                  "value" = var.cloudflare_access_tunnel_mgmt_token
                }
              ]
            }
          ]
        }
      }
    }
  }
  depends_on = [kubernetes_manifest.namespace_cloudflare_access]
}
