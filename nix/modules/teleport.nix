{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ teleport ];
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
      sleep 60
      ${pkgs.teleport}/bin/tctl create << EOF
      kind: role
      version: v7
      metadata:
        name: admin-login
      spec:
        allow:
          node_labels:
            '*': '*'
          logins: ['admin']
      EOF
      sleep 5
      ${pkgs.teleport}/bin/tctl create << EOF
      kind: github
      version: v3
      metadata:
        name: github
      spec:
        client_id: TP_GH_CLIENT_ID
        client_secret: TP_GH_CLIENT_SECRET
        redirect_url: https://access.morrislan.net:443/v1/webapi/github/callback
        teams_to_roles:
        - organization: MorrisLAN
          roles:
          - admin-login
          - auditor
          - access
          - editor
          team: admins
      EOF
      systemctl restart teleport.service
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };
}