resource "helm_release" "argocd_mgmt" {
  depends_on       = [digitalocean_kubernetes_cluster.mgmt]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.7.14"
  namespace        = "argocd"
  create_namespace = true
  values = [
    <<EOT
global:
  domain: argocd-mgmt.morrislan.net

configs:
  params:
    server.insecure: true

server:
  ingress:
    enabled: true
    ingressClassName: nginx
    annotations:
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
      cert-manager.io/cluster-issuer: "letsencrypt"
    extraTls:
      - hosts:
        - argocd-mgmt.morrislan.net
        secretName: argocd-tls
EOT
  ]
}