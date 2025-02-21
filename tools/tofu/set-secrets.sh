#!/bin/bash
export AWS_ACCESS_KEY_ID="$(vault-get do#spaces-access-key-id)"
export AWS_SECRET_ACCESS_KEY="$(vault-get do#spaces-secret-access-key)"
export TF_VAR_do_token="$(vault-get do#token)"
export TF_VAR_vultr_token="$(vault-get vultr#token)"
export TF_VAR_cloudflare_token="$(vault-get cloudflare#token)"
export TF_VAR_cloudflare_account_id="$(vault-get cloudflare#account-id)"
