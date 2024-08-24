#!/bin/bash

if which mongosh > /dev/null 2>&1; then
  mongo_init_bin='mongosh'
else
  mongo_init_bin='mongo'
fi
"${mongo_init_bin}" <<EOF
use admin
db.auth("root", "${UNIFI_DB_ROOT_PASS}")
db.createUser({
  user: "UNIFI",
  pwd: "${UNIFI_DB_PASS}",
  roles: [
    { db: "UNIFI", role: "dbOwner" },
    { db: "UNIFI_stat", role: "dbOwner" }
  ]
})
EOF