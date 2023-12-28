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

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    desktopManager = {
      cinnamon.enable = true;
    };
    displayManager.defaultSession = "cinnamon";
  };

  system.stateVersion = "23.11";
}
