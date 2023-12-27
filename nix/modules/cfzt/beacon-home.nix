{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ socat ];
  users.users = {
    cfzt-beacon-home = {
      group = "cfzt-beacon-home";
      isSystemUser = true;
    };
  };
  users.groups.cfzt-beacon-home = { };

  systemd.services.cfzt-beacon-home = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      User = "cfzt-beacon-home";
      Group = "cfzt-beacon-home";
    };
    script = ''
    #!/bin/bash
    CERTIFICATE="SECRET_CFZT_BEACON_HOME_CERT"
    PRIVATE_KEY="SECRET_CFZT_BEACON_HOME_KEY"
    CERTIFICATE=$(echo $CERTIFICATE | base64 -d)
    PRIVATE_KEY=$(echo $PRIVATE_KEY | base64 -d)

    CERT_FILE=$(mktemp)
    PRIVATE_KEY_FILE=$(mktemp)

    echo "$CERTIFICATE" > "$CERT_FILE"
    echo "$PRIVATE_KEY" > "$PRIVATE_KEY_FILE"

    ${pkgs.socat}/bin/socat OPENSSL-LISTEN:8123,cert=$CERT_FILE,key=$PRIVATE_KEY_FILE,verify=0,reuseaddr,fork SYSTEM:"echo 'HTTP/1.1 200 OK'; echo 'Content-Type: text/plain'; echo; echo 'Cloudflare Zero Trust Beacon - Home'"
    '';
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}