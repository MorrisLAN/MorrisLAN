#!/bin/bash
# Script to bootstrap/provision k8s clusters using Sidero Omni
set -e

if [ -z "$1" ]; then
    echo "Usage: omni-bootstrap <cluster-name>"
    exit 1
fi

CLUSTER_DIR="$1"

if [ ! -d "$CLUSTER_DIR" ]; then
    echo "Error: Directory '$CLUSTER_DIR' does not exist."
    exit 1
fi

# Find the cluster and machine classes YAML files in the specified directory (non-recursive)
CLUSTER_YAML=$(find "$CLUSTER_DIR" -maxdepth 1 -type f -name '*-cluster.yaml' | head -n 1)
MACHINE_CLASSES_YAML=$(find "$CLUSTER_DIR" -maxdepth 1 -type f -name '*-machineclasses.yaml' | head -n 1)

if [ -z "$CLUSTER_YAML" ] || [ -z "$MACHINE_CLASSES_YAML" ]; then
    echo "ERR: Either cluster or machineclasses YAML not found in '$CLUSTER_DIR'."
    exit 1
fi

echo "Applying machine classes: $MACHINE_CLASSES_YAML"
omnictl apply -f "$MACHINE_CLASSES_YAML"

echo "Syncing cluster template: $CLUSTER_YAML"
omnictl cluster template sync -f "$CLUSTER_YAML"
