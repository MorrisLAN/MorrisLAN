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
        configDir = "/var/lib/cni/net.d";
    };
    clusterCidr = "10.55.0.0/16";
    apiserver = {
      allowPrivileged = true;
      securePort = 6443;
      advertiseAddress = "10.1.240.5";
    };
    flannel.enable = false;
  };
}