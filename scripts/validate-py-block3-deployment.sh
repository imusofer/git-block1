#!/bin/bash
set -euo pipefail

kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-service.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-deployment.yaml
if kubectl rollout status deployment/py-block3-deployment --timeout=60s; then
  printf '\n=== Rollout succeeded ===\n'
  kubectl get pods -l app=py-block3
  exit 0
else
  printf '\n=== Deployment summary ===\n'
  kubectl get deployment py-block3-deployment
  printf '\n=== Deployment details ===\n'
  kubectl describe deployment py-block3-deployment
  printf '\n=== Pods details ===\n'
  kubectl describe pods -l app=py-block3
  printf '\n=== Pods logs ===\n'
  kubectl logs -l app=py-block3 --tail=5 --prefix=true
  printf '\n=== Recent Deployment Warning events ===\n'
  kubectl events --for deployment/py-block3-deployment --types=Warning
  printf '\n=== Recent Pod Warning events ===\n'
  for pod in $(kubectl get pods -l app=py-block3 -o name); do
    kubectl events --for "$pod" --types=Warning
  done
  exit 1
fi
