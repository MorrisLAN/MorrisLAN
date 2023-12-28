{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware/qemu-aarch64.nix
    ./modules/base.nix
    ./modules/cicd/github-runners/home-aarch64.nix
  ];

  networking = {
    hostName = "vm-maxdev01";
    networkmanager.enable = false;
    useDHCP = false;
    interfaces.enp0s1 = {
      ipv4.addresses = [{
       address = "10.1.240.52";
       prefixLength = 24;
      }];
    };
  };

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.desktopManager.gnome.enable = true;

  system.stateVersion = "23.11";
}
