#!/bin/bash

REPO_DIR="/tmp/morrislan"
rm -r ${REPO_DIR}
nix-shell -p git --command "git clone https://git.morrislan.net/MorrisLAN/morrislan ${REPO_DIR}"

if [[ $HOSTNAME =~ ^hc-ch-[0-9]+$ ]]; then
  kubectl create namespace argocd
  kubectl apply -n argocd -f ${REPO_DIR}/k8s/argocd -f ${REPO_DIR}/k8s/argocd/hc
  sleep 1m
  kubectl apply -n argocd -f ${REPO_DIR}/k8s/argocd -f ${REPO_DIR}/k8s/argocd/hc
fi