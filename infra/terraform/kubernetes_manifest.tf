resource "kubernetes_manifest" "namespace_hoopdev" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = "hoopdev"
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
