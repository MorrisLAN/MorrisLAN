#!/bin/bash
# Script to quickly image Hetzner nodes (Cloud/Robot) via Rescue
set -e
NODE="$1"
IMAGE="$2"
NODE_TYPE="$3"

if [ -z "$NODE" ] || [ -z "$IMAGE" ] || [ -z "$NODE_TYPE" ]; then
    echo "Usage: hetzner-image <host> <image-url> <node-type (cloud/robot)>"
    exit 1
fi

if [[ "$NODE_TYPE" == "cloud" ]]; then
    INSTALL_DRIVE="/dev/sda"
elif [[ "$NODE_TYPE" == "robot" ]]; then
    INSTALL_DRIVE="/dev/nvme0n1"
else
    echo "Invalid node type. Please enter 'cloud' or 'robot'."
    exit 1
fi

read -sp "Password: " SSHPASS
echo

sshpass -p "$SSHPASS" ssh -o StrictHostKeyChecking=no root@$NODE <<EOF
echo "Wiping existing data on $INSTALL_DRIVE..."
wipefs --all $INSTALL_DRIVE

echo "Downloading image from $IMAGE..."
wget -O /tmp/img.zst $IMAGE

echo "Writing image to $INSTALL_DRIVE..."
zstd -d --stdout /tmp/img.zst | dd of=$INSTALL_DRIVE status=progress && sync

echo "Rebooting node..."
shutdown -r now
EOF
