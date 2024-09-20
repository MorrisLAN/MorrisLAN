#!/bin/bash

if [[ $HOST =~ ^hc-ch-[0-9]+\.morrislan\.net$ ]]; then
  kubectl apply -f argocd
  sleep 1m
  kubectl apply -f argocd/hc
fi