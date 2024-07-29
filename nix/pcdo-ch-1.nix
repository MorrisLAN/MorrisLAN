{ modulesPath, config, pkgs, lib, ... }: {
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
    ./modules/base.nix
    ./modules/ch.nix
  ];

  networking = {
    hostName = "pcdo-ch-1";
  };

  systemd.services.traefik = {
    description = "Traefik (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/traefik/docker-compose.yml up";
      WorkingDirectory = "/etc/morrislan/docker/compose/traefik";
      Restart = "always";
    };
  };

  systemd.services.gitea = {
    description = "Gitea (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/gitea/docker-compose.yml up";
      WorkingDirectory = "/etc/morrislan/docker/compose/gitea";
      Restart = "always";
    };
  };

  system.stateVersion = "24.05";
}
