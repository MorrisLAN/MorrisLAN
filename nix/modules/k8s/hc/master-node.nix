{ config, pkgs, ... }:
{
  
  networking = {
    extraHosts = 
    ''
      10.1.240.5 hc-ch-api.morrislan.net
      10.1.240.5 hc-ch-1.morrislan.net
    '';
  };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    openiscsi # Needed for Longhorn
    jq # Needed for Longhorn
    k9s
    kubernetes-helm
  ];

  # Needed for Longhorn
  services.openiscsi = {
    enable = true;
    name = config.networking.hostName;
  };
  virtualisation.docker.logDriver = "json-file";

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "hc-ch-api.morrislan.net";
    apiserverAddress = "https://hc-ch-api.morrislan.net:6443";
    easyCerts = true;
    addons.dns.enable = true;
    kubelet = {
      extraOpts = "--fail-swap-on=false";
    };
    apiserver = {
      allowPrivileged = true;
      securePort = 6443;
      advertiseAddress = "10.1.240.5";
    };
    proxy = {
      extraOpts = "--ipvs-strict-arp=true";
    };
  };
}