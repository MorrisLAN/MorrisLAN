#!/bin/bash

TELEMETRY_JSON='{
  "telemetryLevel": "full",
  "server": "'"$1"'",
  "path": "/results/telemetry.php",
  "shareURL": "/results/"
}'

SERVER_JSON='[
  {
    "id": 1,
    "name": "'"$1"'",
    "server": "'"$1/backend"'",
    "dlURL": "garbage.php",
    "ulURL": "empty.php",
    "pingURL": "empty.php",
    "getIpURL": "getIP.php"
  }
]'

echo ${TELEMETRY_JSON} > /tmp/librespeed-telemetry
echo ${SERVER_JSON} > /tmp/librespeed-server
librespeed-cli --local-json /tmp/librespeed-server --server 1 --share --telemetry-json /tmp/librespeed-telemetry
rm /tmp/librespeed-telemetry /tmp/librespeed-server
