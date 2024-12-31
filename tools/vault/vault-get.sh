#!/bin/bash
# Helper script for getting KV secrets from Vault
set -e
VAULT_ADDR="https://vault.morrislan.net"

if [ -z "$1" ]; then
    echo "Usage: vault-get <path[#key]>"
    exit 1
fi

IFS='#' read -r VAULT_PATH VAULT_KEY <<< "$1"

source /usr/bin/vault-check-token
VAULT_JSON=$(/usr/bin/vault kv get -mount="secrets" -format=json "${VAULT_PATH}")

if [ -n "${VAULT_KEY}" ]; then
    VALUE=$(echo "${VAULT_JSON}" | /usr/bin/jq -r ".data.data[\"$VAULT_KEY\"]")
    echo "${VALUE}"
else
    echo "${VAULT_JSON}" | /usr/bin/jq -r '.data.data | to_entries[] | "\(.key): \(.value)"'
fi
