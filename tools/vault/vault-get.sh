#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <path[#key]>"
    exit 1
fi

IFS='#' read -r PATH KEY <<< "$1"

VAULT_JSON=$(/usr/bin/vault kv get -format=json "${PATH}")

if [ -n "${KEY}" ]; then
    VALUE=$(echo "${VAULT_JSON}" | /usr/bin/jq -r ".data.data[\"$KEY\"]")
    echo "${VALUE}"
else
    echo "${VAULT_JSON}" | /usr/bin/jq -r '.data.data | to_entries[] | "\(.key): \(.value)"'
fi
