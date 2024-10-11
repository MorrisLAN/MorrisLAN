#!/bin/bash
# Helper script for SSHing to nodes via Vault
if [ -z "$1" ]; then
    echo "Usage: vssh <host>"
    return 1
fi

VAULT_ADDR="https://vault.morrislan.net"
HOST="$1"
CLUSTER="${HOST%%-node-*}"

vault token lookup >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Attempting to log in with OIDC..."
    vault login --method oidc
fi
vault ssh -strict-host-key-checking=no -mode ca -role ssh -mount-point ${CLUSTER}-ssh ubuntu@${HOST} -o IdentityAgent=null