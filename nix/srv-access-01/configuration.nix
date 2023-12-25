{ config, pkgs, lib, ... }: {
  imports = [
    ../base.nix
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  environment.systemPackages = with pkgs; [ cloudflared teleport ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 4022 ];
  networking = {
    hostName = "srv-access-01";
    domain = "morrislan.net";
    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [{
       address = "10.1.240.5";
       prefixLength = 24;
      }];
    };
    defaultGateway = "10.1.240.1";
    nameservers = [ "10.1.240.3" ];
  };

  users.users = {
    cloudflared = {
      group = "cloudflared";
      isSystemUser = true;
    };
  };
  users.groups.cloudflared = { };

  systemd.services.cloudflared = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=MORRISLAN_TUNNEL_TOKEN";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };

  services.teleport = {
    enable = true;
    settings = {
      teleport = {
        nodename = config.networking.hostName;
      };
      auth_service = {
        enabled = true;
        listen_addr = "127.0.0.1:3025";
        cluster_name = "access.morrislan.net";
        authentication = {
          type = "github";
          local_auth = false;
        };
      };
      proxy_service = {
        enabled = true;
        web_listen_addr = "127.0.0.1:443";
        public_addr = "access.morrislan.net:443";
      };
      ssh_service = {
        enabled = true;
      };
    };
  };

  systemd.services.teleport-sso = {
    wantedBy = [ "multi-user.target" ];
    script = ''
      #!/bin/sh
      ${pkgs.teleport}/bin/tctl sso configure github --id=TP_GH_CLIENT_ID --secret=TP_GH_CLIENT_SECRET --teams-to-roles=MorrisLAN,admins,auditor,access,editor > /tmp/github.yaml
      sed -i '/endpoint_url:/d' /tmp/github.yaml
      ${pkgs.teleport}/bin/tctl create -f /tmp/github.yaml
      systemctl disable teleport-sso.service
    '';
  };

  system.stateVersion = "23.11";
}