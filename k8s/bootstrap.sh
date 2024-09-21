#!/bin/bash

if [[ $HOSTNAME =~ ^hc-ch-[0-9]+$ ]]; then
  kubectl create namespace argocd
  kubectl apply -n argocd -f argocd -f argocd/hc
  sleep 1m
  kubectl apply -n argocd -f argocd -f argocd/hc
fi