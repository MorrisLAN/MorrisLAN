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

  environment.systemPackages = with pkgs; [ cloudflared ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 4022 ];
  networking = {
    hostName = "srv-cfzt-01";
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
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=TOKEN_PLACEHOLDER";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}