{ modulesPath, config, pkgs, lib, ... }: {
  imports = [
    ./hardware/dell-r730.nix
    ./modules/base.nix
    ./modules/ch.nix
  ];

  networking = {
    hostName = "hc-ch-1";
    hostId = "c1a068ae";
    bonds.bond0 = {
      interfaces = [ "eno1" "eno2" ];
      driverOptions = {
        mode = "802.3ad";
        miimon = "100";
        lacp_rate = "fast";
      };
    };
    interfaces.bond0 = {
      ipv4.addresses = [{
       address = "10.1.240.5";

       prefixLength = 24;
      }];
    };
    defaultGateway = "10.1.240.1";
    nameservers = [ "10.1.240.1" ];
  };

  systemd.services.traefik = {
    description = "Traefik (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/traefik/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/traefik/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/traefik/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/traefik";
      Restart = "always";
      Environment = [ "CLOUDFLARE_TOKEN=SECRETS.CLOUDFLARE_TOKEN" ];
    };
  };

  systemd.services.cloudflare-tunnel = {
    description = "Cloudflare Tunnel (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/cloudflare-access/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/cloudflare-access/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/cloudflare-access/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/cloudflare-access/";
      Restart = "always";
      Environment = [ "CLOUDFLARE_TUNNEL_TOKEN=SECRETS.CLOUDFLARE_TUNNEL_HC1_TOKEN" ];
    };
  };

  systemd.services.adguard = {
    description = "AdGuard (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/adguard/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/adguard/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/adguard/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/adguard";
      Restart = "always";
    };
  };

  systemd.services.ai-stack = {
    description = "AI Stack (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/ai/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/ai/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/ai/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/ai";
      Restart = "always";
      Environment = [ 
        "OPENWEBUI_OAUTH_ID=SECRETS.OPENWEBUI_OAUTH_ID"
        "OPENWEBUI_OAUTH_SECRET=SECRETS.OPENWEBUI_OAUTH_SECRET"
        ];
    };
  };

  systemd.services.authentik = {
    description = "Authentik (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/authentik/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/authentik/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/authentik/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/authentik";
      Restart = "always";
      Environment = [ 
        "AUTHENTIK_DB_PASS=SECRETS.AUTHENTIK_DB_PASS"
        "AUTHENTIK_SECRET_KEY=SECRETS.AUTHENTIK_SECRET_KEY"
        "AUTHENTIK_PROXY_TOKEN=SECRETS.AUTHENTIK_PROXY_TOKEN"
        "SMTP_HOST=SECRETS.SMTP_HOST"
        "SMTP_USERNAME=SECRETS.SMTP_USERNAME"
        "SMTP_PASSWORD=SECRETS.SMTP_PASSWORD"
        ];
    };
  };

  systemd.services.smart-home = {
    description = "Smart Home (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/smart-home/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/smart-home/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/smart-home/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/smart-home";
      Restart = "always";
    };
  };

  systemd.services.speedtest = {
    description = "Speedtest (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/speedtest/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/speedtest/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/speedtest/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/speedtest";
      Restart = "always";
    };
  };

  systemd.services.unifi = {
    description = "UniFi (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/unifi/" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/unifi/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/unifi/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/unifi";
      Restart = "always";
      Environment = [ 
        "UNIFI_DB_PASS=SECRETS.UNIFI_DB_PASS"
        "UNIFI_DB_ROOT_PASS=SECRETS.UNIFI_DB_ROOT_PASS"
      ];
    };
  };

  systemd.services.gitea-runner = {
    description = "Gitea Runner (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/gitea/runner" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/gitea/runner/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/gitea/runner/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/gitea/runner";
      Restart = "always";
      Environment = [ "CI_HC_RUNNER_TOKEN=SECRETS.CI_HC_RUNNER_TOKEN" ];
    };
  };

  systemd.services.filebrowser = {
    description = "Files (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/filebrowser" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/filebrowser/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/filebrowser/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/filebrowser";
      Restart = "always";
    };
  };

  systemd.services.nextcloud = {
    description = "Nextcloud (Docker Compose)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    restartTriggers = [ "/etc/morrislan/docker/compose/nextcloud" ];
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/nextcloud/docker-compose.yml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/morrislan/docker/compose/nextcloud/docker-compose.yml down";
      WorkingDirectory = "/etc/morrislan/docker/compose/nextcloud";
      Restart = "always";
    };
  };

  system.stateVersion = "24.05";
}
