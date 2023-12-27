{ pkgs ? import <nixpkgs> { } }:
let
  config = {
    imports = [ <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix> ];
  };
in
(pkgs.nixos config).digitalOceanImage

{ config, pkgs, lib, ... }:
{
  imports = [
    ./modules/base.nix
  ];
  nixpkgs = {
    localSystem.system = "x86_64-linux";
    overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];
  };

  networking = {
    hostName = "srv-dotest-01";
    interfaces.eth0 = {
      useDHCP = true;
    };
  };

  system.stateVersion = "23.11";
}