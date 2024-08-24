{ modulesPath, config, pkgs, lib, ... }: {
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
    ./modules/base.nix
    ./modules/ch.nix
  ];

  networking = {
    hostName = "pcdo-ch-1";
    hosts = {
      "127.0.0.1" = [ "git.morrislan.net" ];
    };
  };

  systemd.services.traefik = {
    description = "Traefik (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/traefik/docker-compose.yml" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/traefik/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/traefik/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/traefik";
      Restart = "always";
      Environment = [ "CLOUDFLARE_TOKEN=SECRETS.CLOUDFLARE_TOKEN" ];
    };
  };

  systemd.services.gitea = {
    description = "Gitea (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/gitea/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/gitea/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/gitea";
      Restart = "always";
    };
  };

  systemd.services.cloudflare-tunnel = {
    description = "Cloudflare Tunnel (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/cloudflare-access/docker-compose.yml" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/cloudflare-access/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/cloudflare-access/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/cloudflare-access";
      Restart = "always";
      Environment = [ "CLOUDFLARE_TUNNEL_TOKEN=SECRETS.CLOUDFLARE_TUNNEL_PCDO1_TOKEN" ];
    };
  };

  system.stateVersion = "24.05";
}
