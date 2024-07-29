{ modulesPath, config, pkgs, lib, ... }: {
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
    ./modules/base.nix
    ./modules/ch.nix
  ];

  networking = {
    hostName = "pcdo-ch-1";
  };

  system.stateVersion = "24.05";
}
