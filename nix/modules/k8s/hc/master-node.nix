{ config, pkgs, ... }:
{
  
  networking = {
    extraHosts = 
    ''
      10.1.240.5 hc-ch-1.morrislan.net
      10.1.240.5 hc-ch-api.morrislan.net
    '';
    dhcpcd.denyInterfaces = [ "cali*" "tunl*" "vxlan.calico" ];
  };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    calicoctl
    calico-kube-controllers
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "hc-ch-api.morrislan.net";
    apiserverAddress = "https://hc-ch-api.morrislan.net:6443";
    easyCerts = true;
    addons.dns.enable = true;
    kubelet = {
      extraOpts = "--fail-swap-on=false";
      cni = {
        packages = with pkgs; [ calico-cni-plugin ];
        config = [
          {
            "cniVersion" = "0.3.1";
            "name" = "k8s-pod-network";
            "type" = "calico";
            "plugins" = [
              {
                "type" = "calico";
                "log_level" = "info";
                "log_file_path" = "/var/log/calico/cni/cni.log";
                "datastore_type" = "kubernetes";
                "mtu" = 1500;
                "nodename" = config.networking.hostName;
                "ipam" = {
                  "type" = "calico-ipam";
                };
                "policy" = {
                  "type" = "k8s";
                };
                "kubernetes" = {
                  "kubeconfig" = "/etc/kubernetes/cluster-admin.kubeconfig";
                };
              }
              {
                "type" = "portmap";
                "capabilities" = {
                  "portMappings" = true;
                };
                "snat" = true;
              }
              {
                "type" = "bandwidth";
                "capabilities" = {
                  "bandwidth" = true;
                };
              }
            ];
          }
          {
            "cniVersion" = "0.3.1";
            "type" = "loopback";
          }
        ];
      };
    };
    apiserver = {
      securePort = 6443;
      advertiseAddress = "10.1.240.5";
    };
    flannel.enable = false;
  };
}