{ config, pkgs, lib, ... }: {
  imports = [
    <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix>
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