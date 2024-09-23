{ config, pkgs, ... }:
{
  
  networking = {
    extraHosts = 
    ''
      10.1.240.5 hc-ch-api.morrislan.net
      10.1.240.5 hc-ch-1.morrislan.net
    '';
  };

  boot.kernelModules = [ "rbd" "ceph" "nbd" "overlay" "br_netfilter" ];

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    openiscsi # Needed for Longhorn
    jq # Needed for Longhorn
    k9s
    kubernetes-helm
    ceph
    ceph-client
    ceph-csi
  ];

  programs.zsh.shellAliases = 
  {
    k = "kubectl";
    "who-owns-port" = "ss -lptn 'sport = :${PORT}'"
  };

  # Needed as NixOS uses /var/lib/kubernetes as kubelet root-dir but I can't be bothered to change that in everything that expects it to be /var/lib/kubelet
  systemd.tmpfiles.rules = [
    "L+ /var/lib/kubelet - - - - /var/lib/kubernetes"
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