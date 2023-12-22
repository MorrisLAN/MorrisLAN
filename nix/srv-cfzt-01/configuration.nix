{ config, pkgs, lib, ... }: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ vim curl wget nano neofetch cloudflared ];

  services.openssh = {
      enable = true;
      ports = [ 4022 ];
      passwordAuthentication = false;
  };

  programs.zsh = {
      enable = true;
      ohMyZsh = {
          enable = true;
          theme = "af-magic";
      };
  };

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

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = false;
  users.users = {
    admin = {
      uid = 1000;
      isNormalUser = true;
      home = "/home/admin";
      name = "admin";
      group = "admin";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjgkh0LyGVjWzYnCxrKC5dxQMHE3ky7s/vFpAyjfk5l"
      ];
    };
    cloudflared = {
      group = "cloudflared";
      isSystemUser = true;
    };
  };
  users.groups.admin = {};
  users.groups.cloudflared = { };

  systemd.services.morrislan_tunnel = {
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