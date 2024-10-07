resource "digitalocean_kubernetes_cluster" "rancher" {
  name   = "rancher"
  region = "lon1"
  version = "latest"

  node_pool {
    name       = "node"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}

data "digitalocean_kubernetes_cluster" "rancher" {
  name = digitalocean_kubernetes_cluster.rancher.name
}

provider "kubernetes" {
  config_path = data.digitalocean_kubernetes_cluster.rancher.kube_config.0.raw_config
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  create_namespace = true
  version    = "v1.15.3"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "kubernetes_secret" "cloudflare_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "cert-manager"
  }

  data = {
    api-token = base64encode(var.cloudflare_token)
  }
}

resource "kubernetes_manifest" "letsencrypt_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt"
    }
    "spec" = {
      "acme" = {
        "email"  = "le@maxmorris.io"
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "privateKeySecretRef" = {
          "name" = "letsencrypt-cloudflare-key"
        }
        "solvers" = [
          {
            "dns01" = {
              "cloudflare" = {
                "apiTokenSecretRef" = {
                  "name" = "cloudflare-api-token-secret"
                  "key"  = "api-token"
                }
              }
            }
          }
        ]
      }
    }
  }
}

resource "helm_release" "rancher" {
  name       = "rancher"
  repository = "https://releases.rancher.com/server-charts/stable"
  chart      = "rancher"
  namespace  = "cattle-system"
  create_namespace = true

  set {
    name  = "hostname"
    value = "rancher.morrislan.net"
  }

  set {
    name  = "ingress.tls.source"
    value = "letsencrypt"
  }
}

# Outputs
output "rancher_url" {
  value = "https://rancher.morrislan.net"
}
