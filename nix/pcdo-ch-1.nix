{ config, pkgs, lib, ... }: {
  imports = [
    <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix>
    ./modules/base.nix
  ];

  networking = {
    hostName = "pcdo-ch-1";
    networkmanager.enable = true;
    useDHCP = true;
  };

  system.stateVersion = "24.05";
}
