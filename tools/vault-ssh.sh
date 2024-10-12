#!/bin/bash
# Helper script for SSHing to nodes via Vault
if [ -z "$1" ]; then
    echo "Usage: vssh <host>"
    exit 1
fi

VAULT_ADDR="https://vault.morrislan.net"
HOST="$1"

# This is a naming mistake I am now paying for
if [[ ${HOST} == metal-* ]]; then
    CLUSTER="metal"
    USER="rancher"
else
    CLUSTER="${HOST%%-node-*}"
    USER="ubuntu"
fi

vault token lookup >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Attempting to log in with OIDC..."
    vault login --method oidc
fi

vault ssh -strict-host-key-checking=no -mode ca -role ssh -mount-point ${CLUSTER}-ssh ${USER}@${HOST} -o IdentityAgent=null -t "sudo -i"
