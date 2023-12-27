{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ socat ];
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

    ${pkgs.socat}/bin/socat OPENSSL-LISTEN:8123,cert=$CERT_FILE,key=$PRIVATE_KEY_FILE,verify=0,reuseaddr,fork SYSTEM:"echo 'HTTP/1.1 200 OK'; echo 'Content-Type: text/plain'; echo; echo 'Cloudflare Zero Trust Beacon - Home'" &
    echo $! > /tmp/cfzt-home-mn-tls.pid

    rm "$CERT_FILE" "$PRIVATE_KEY_FILE"

    exit 0

    '';
  };
}