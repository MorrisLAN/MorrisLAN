#!/bin/bash
# Helper script to check if Vault token is valid
set -e
VAULT_ADDR="https://vault.morrislan.net"

if ! /usr/bin/vault token lookup >/dev/null 2>&1; then
    /usr/bin/vault login --method oidc
fi
