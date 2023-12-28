{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware/rpi4.nix
    ./modules/base.nix
    ./modules/cfzt/tunnel-home.nix
    ./modules/cfzt/beacon-home.nix
  ];

  networking = {
    hostName = "srv-cfzt-01";
    networkmanager.enable = false;
    useDHCP = false;
    interfaces.eth0 = {
      ipv4.addresses = [{
       address = "10.1.240.5";
       prefixLength = 24;
      }];
    };
  };

  system.stateVersion = "23.11";
}
