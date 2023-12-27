{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ nmap ];
  users.users = {
    cfzt-home-mn-tls = {
      group = "cfzt-home-mn-tls";
      isSystemUser = true;
    };
  };
  users.groups.cfzt-home-mn-tls = { };

  systemd.services.cfzt-home-mn-tls = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      User = "cfzt-home-mn-tls";
      Group = "cfzt-home-mn-tls";
    };
    script = ''
    #!/bin/bash
    CERTIFICATE="SECRET_CFZT_HOME_MN_CERT"
    PRIVATE_KEY="SECRET_CFZT_HOME_MN_KEY"
    CERTIFICATE=$(echo $CERTIFICATE | base64 -d)
    PRIVATE_KEY=$(echo $PRIVATE_KEY | base64 -d)

    CERT_FILE=$(mktemp)
    PRIVATE_KEY_FILE=$(mktemp)

    echo "$CERTIFICATE" > "$CERT_FILE"
    echo "$PRIVATE_KEY" > "$PRIVATE_KEY_FILE"

    ${pkgs.nmap}/bin/ncat --ssl --ssl-cert "$CERT_FILE" --ssl-key "$PRIVATE_KEY_FILE" -l -p 8123 --exec "/bin/cat" &
    echo $! > /var/run/cfzt-home-mn-tls.pid

    rm "$CERT_FILE" "$PRIVATE_KEY_FILE"

    exit 0

    '';
  };
}