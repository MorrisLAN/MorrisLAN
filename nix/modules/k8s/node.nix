{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [ kubernetes kubectl ];
  };

  services.kubernetes = {
    roles = ["master" "node"];
      apiserver = {
        securePort = 8443;
        advertiseAddress = "10.1.240.5";
      };
    masterAddress = "api.kube";
    easyCerts = true;
    kubelet.extraOpts = "--fail-swap-on=false";
  };

}
