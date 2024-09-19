{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [ vim curl btop lsof wget nano fastfetch ];
    etc."morrislan".source = builtins.fetchGit {
      url = "https://ci:SECRETS.GIT_PAT@git.morrislan.net/MorrisLAN/morrislan.git";
      ref = "refs/heads/prod";
    };

    # etc."vault_ssh/public_key".source = builtins.fetchurl {
    #   url = "https://vault.morrislan.net/v1/ssh/public_key";
    # };
  };

  # Needed for Longhorn (but just generally not bad either)
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  networking = {
    firewall.enable = false;
    domain = "morrislan.net";
    usePredictableInterfaceNames = true;
  };

  services.openssh = {
      enable = true;
      ports = [ 4022 ];
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        TrustedUserCAKeys = "/etc/vault_ssh/public_key";
      };
  };

  programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
          enable = true;
          theme = "risto";
          plugins = [ "git" ];
      };
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
    deploy = {
      uid = 1001;
      isNormalUser = true;
      shell = pkgs.bash;
      openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYCwZSrRviTaFVOF8txcsBV4o3vBwvevFC8XSxsTvev MorrisLAN CI (NixOS Deploy Key)"
      ];
    };
  };
  nix.settings.trusted-users = [ "deploy" ];
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "deploy" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nix-env";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemd-run";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
  users.groups.admin = {};
  security.sudo.wheelNeedsPassword = false;
}
