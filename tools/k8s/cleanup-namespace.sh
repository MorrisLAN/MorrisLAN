#!/bin/bash
# Removes finalizers from stubborn namespaces that won't delete
NAMESPACE=$1

kubectl get namespace "$NAMESPACE" -o json \
  | tr -d "\n" \
  | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f -
