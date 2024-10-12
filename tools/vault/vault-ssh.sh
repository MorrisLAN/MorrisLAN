#!/bin/bash
# Helper script for SSHing to nodes via Vault
set -e
VAULT_ADDR="https://vault.morrislan.net"
HOST="$1"

if [ -z "$1" ]; then
    echo "Usage: vssh <host>"
    exit 1
fi

# This is a naming mistake I am now paying for
if [[ ${HOST} == metal-* ]]; then
    CLUSTER="metal"
    USER="rancher"
else
    CLUSTER="${HOST%%-node-*}"
    USER="ubuntu"
fi

source /usr/bin/vault-check-token.sh
/usr/bin/vault ssh -strict-host-key-checking=no -mode ca -role ssh -mount-point ${CLUSTER}-ssh ${USER}@${HOST} -o IdentityAgent=null -t "sudo -i"
