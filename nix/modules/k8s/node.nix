{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [ kubernetes kubectl ];
  };

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "10.1.240.5";
    easyCerts = true;
    kubelet.extraOpts = "--fail-swap-on=false";
  };

}
