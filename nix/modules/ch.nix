{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [ docker-compose ];
  
}
