#!/bin/bash
set -e

# Wait for do-agent DPKG lock to release
while true; do
    if [ ! -f /var/lib/dpkg/lock ] && [ ! -f /var/lib/apt/lists/lock ]; then
        break
    else
        echo "Waiting for APT/DPKG to be available..."
        sleep 5
    fi
done

# Install Teleport
curl https://goteleport.com/static/install.sh | bash -s 14.2.3

# Generate Teleport cert
openssl req -new -key /var/lib/teleport/privkey.pem -out /tmp/teleport.csr -subj "/C=GB/ST=Avon/L=Bristol/O=MorrisLAN/CN=access.morrislan.net"
openssl x509 -req -days 1095 -in /tmp/teleport.csr -signkey /var/lib/teleport/privkey.pem -out /var/lib/teleport/fullchain.pem
cp /var/lib/teleport/fullchain.pem /etc/ssl/certs/teleport.pem

# Configure Teleport
teleport configure -o file --cluster-name=access.morrislan.net --public-addr=access.morrislan.net:443 --cert-file=/var/lib/teleport/fullchain.pem --key-file=/var/lib/teleport/privkey.pem
systemctl enable --now teleport

sleep 25

# Create Teleport root user
tctl users add root --roles=auditor,editor,access --logins=admin

# Setup GitHub SSO
tctl sso configure github --id=${gh_client_id} --secret=${gh_client_secret} --teams-to-roles=morrislan,admins,auditor,editor,access

# Install cloudflared
apt update && apt install -y cloudflared

# Configure Cloudflare Tunnel
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared.deb && 
sudo cloudflared service install ${dovpc_tunnel_token}

# Stop OpenSSH
systemctl disable sshd

reboot
