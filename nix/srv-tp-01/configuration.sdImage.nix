{ config, lib, pkgs, ... }: {
  nixpkgs.localSystem.system = "x86_64-linux";
  imports = [
    <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix>
    ./configuration.nix
  ];
}
