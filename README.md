# 🖧 morrislan

### Infrastructure as Code (IaC) for [my](https://maxmorris.io) personal network/digital infrastructure.
![build](https://git.morrislan.net/MorrisLAN/morrislan/actions/workflows/build.yaml/badge.svg?branch=main)
![deploy](https://git.morrislan.net/MorrisLAN/morrislan/actions/workflows/deploy.yaml/badge.svg?branch=main)

🔧 **Technologies in Use:**

- [Gitea](https://about.gitea.com/) - GitOps/CI platform [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v3/monitor/1r45s.svg)](https://status.morrislan.net)
- [OpenTofu](https://opentofu.org/) - IaC tool
- [Kubernetes (k8s)](https://kubernetes.io/) - workload/container orchestrator
- [netbird](https://netbird.io/) - open-source P2P VPN
- [Talos Linux](https://www.talos.dev/) - API-managed OS that is purpose built for running k8s
- [Omni](https://omni.siderolabs.com/) - centralised machine & cluster management for Talos [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v3/monitor/1r45u.svg)](https://status.morrislan.net)
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) - GitOps for k8s [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v3/monitor/1r45o.svg)](https://status.morrislan.net)
- [ingress-nginx](https://github.com/kubernetes/ingress-nginx) - ingress controller for k8s
- [cert-manager](https://cert-manager.io/) - automated certificate retrieval for k8s
- [external-dns](https://kubernetes-sigs.github.io/external-dns/v0.14.0/) - provisioning of DNS records from within k8s
- [authentik](https://goauthentik.io/) - Identity provider/user management for SSO [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v3/monitor/1r45r.svg)](https://status.morrislan.net)
- [Cloudflare Access/Tunnels](https://www.cloudflare.com/en-gb/zero-trust/products/access/) - Secure access to services & apps
- [Home Assistant](https://www.home-assistant.io/) - Smart home controller
- [generic-device-plugin](https://github.com/squat/generic-device-plugin) - attaches special Linux devices to k8s pods
- [Kata Containers](https://katacontainers.io/) - VM-based container runtime
- [Falco](https://falco.org/) - threat analysis tool
- [LibreSpeed](https://github.com/librespeed/speedtest) - Self hosted speedtest
- [metrics-server](https://github.com/kubernetes-sigs/metrics-server) - k8s metrics API
- [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) - monitoring/metrics stack
- [rook-ceph](https://rook.io/) - distributed storage for k8s
- [Trivy Operator](https://github.com/aquasecurity/trivy-operator) - security toolkit for k8s
- [Vault](https://www.vaultproject.io/) - secrets management engine [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v3/monitor/1r48d.svg)](https://status.morrislan.net)
- [metrics-server](https://kubernetes-sigs.github.io/metrics-server/) - resource metrics for k8s