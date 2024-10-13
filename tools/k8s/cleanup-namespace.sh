#!/bin/bash

NAMESPACE=$1

kubectl get pv "$NAMESPACE" -o json \
  | tr -d "\n" \
  | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw "/api/v1/persistentvolume/$NAMESPACE/finalize" -f -
