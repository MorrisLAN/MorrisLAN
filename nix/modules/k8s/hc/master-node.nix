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
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "hc-ch-api.morrislan.net";
    apiserverAddress = "https://hc-ch-api.morrislan.net:6443";
    easyCerts = true;
    addons.dns.enable = true;
    clusterCidr = "10.0.20.0/23";
    kubelet = {
      extraOpts = "--fail-swap-on=false";
      cni = {
        packages = with pkgs; [ calico-cni-plugin ];
      };
    };
    apiserver = {
      allowPrivileged = true;
      securePort = 6443;
      advertiseAddress = "10.1.240.5";
    };
  };

  environment.etc."cni/net.d/calico-kubeconfig".source = "/tmp/calico-kubeconfig";

}