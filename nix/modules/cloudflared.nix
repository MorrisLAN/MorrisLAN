{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ cloudflared ];

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
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=SECRET_CFZT_HOME_TUNNEL_TOKEN";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}