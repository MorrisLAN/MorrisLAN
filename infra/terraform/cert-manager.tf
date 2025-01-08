resource "helm_release" "cert_manager" {
  depends_on       = [digitalocean_kubernetes_cluster.mgmt]
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version = "1.16.2"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "crds.enabled"
    value = "true"
  }
  set {
    name  = "crds.keep"
    value = "true"
  }
}

resource "kubernetes_secret" "cloudflare_token" {
  metadata = {
    name      = "cloudflare-token"
    namespace = "cloudflare-access"
  }

  data = {
    "token" = base64encode(var.cloudflare_token)
  }

  type = "Opaque"
}


resource "kubernetes_manifest" "clusterissuer_letsencrypt" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt"
    }
    "spec" = {
      "acme" = {
        "solvers" = [
          {
            "dns01" = {
              "cloudflare" = {
                "apiTokenSecretRef" = {
                  "name" = "cloudflare-token"
                  "key"  = "token"
                }
              }
            }
          }
        ]
      }
    }
  }
}
