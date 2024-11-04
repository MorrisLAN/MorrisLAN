{ config, pkgs, ... }:
{
  
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
		rke2
  ];

  programs.zsh.shellAliases = 
  {
    k = "kubectl";
    "who-owns-port" = "ss -lptn 'sport = :${PORT}'"
  };

  # Needed for Longhorn
  services.openiscsi = {
    enable = true;
    name = config.networking.hostName;
  };
  virtualisation.docker.logDriver = "json-file";

}
