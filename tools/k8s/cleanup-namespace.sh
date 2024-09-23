#!/bin/bash

NAMESPACE=$1

if [ -z "${NAMESPACE}" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

# Dump namespace JSON
kubectl get namespace ${NAMESPACE} -o json > ${NAMESPACE}-namespace.json

# Remove finalizers
jq '.spec.finalizers = []' ${NAMESPACE}-namespace.json > ${NAMESPACE}-namespace-temp.json

# Apply updated JSON
kubectl replace --raw "/api/v1/namespaces/${NAMESPACE}/finalize" -f ${NAMESPACE}-namespace-temp.json

# Clean up
rm ${NAMESPACE}-namespace.json ${NAMESPACE}-namespace-temp.json
kubectl get namespace ${NAMESPACE}