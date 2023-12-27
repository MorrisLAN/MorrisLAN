{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware/qemu-aarch64.nix
    ./modules/base.nix
  ];

  networking = {
    hostName = "vm-maxdev01";
    interfaces.eth0 = {
      useDHCP = true;
    };
  };

  system.stateVersion = "23.11";
}