{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ git outils nginx ];

  users.users = {
    cicd = {
      group = "cicd";
      isSystemUser = true;
    };
  };
  users.groups.cicd = { };

  systemd.tmpfiles.rules = [ "d /build 0700 cicd cicd -" ];

  services.nginx = {
    enable = true;
    user = "cicd";
    virtualHosts."builds.morrislan.net" = {
      listen = [ { addr = "0.0.0.0"; port = 8080; } ];
      locations."/" = {
        root = "/build/output";
        extraConfig = "autoindex on;";
      };
    };
  };


  networking.firewall.allowedTCPPorts = [ 8080 ];
}
