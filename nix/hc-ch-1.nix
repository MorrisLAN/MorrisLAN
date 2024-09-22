{ modulesPath, config, pkgs, lib, ... }: {
  imports = [
    ./hardware/dell-r730.nix
    ./modules/base.nix
    ./modules/ch.nix
    ./modules/k8s/hc/master-node.nix
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
    firewall.allowedTCPPorts = [ 80 443 11000 6443 10250 ]; # 11000 Needed for Nextcloud 10250 Needed for metrics-server
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
  system.stateVersion = "24.05";
}
