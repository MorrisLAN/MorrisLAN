{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware/rpi4.nix
    ./modules/base.nix
    ./modules/cfzt/tunnel-home.nix
    ./modules/cfzt/beacon-home.nix
    ./modules/github-runners/home-aarch64.nix
  ];

  networking = {
    hostName = "srv-cfzt-01";
    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [{
       address = "10.1.240.5";
       prefixLength = 24;
      }];
    };
  };

  system.stateVersion = "23.11";
}