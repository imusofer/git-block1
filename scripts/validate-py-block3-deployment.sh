#!/bin/bash
set -euo pipefail

kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-service.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-deployment.yaml
if kubectl rollout status deployment/py-block3-deployment --timeout=60s; then
  echo "Rollout succeeded"
  kubectl get pods -l app=py-block3
  exit 0
else
  echo "Rollout failed"
  kubectl get deployment py-block3-deployment
  kubectl describe deployment py-block3-deployment
  kubectl describe pods -l app=py-block3
  kubectl logs -l app=py-block3 --tail=5 --prefix=true
  echo "Recent deployment events:"
  kubectl events --for deployment/py-block3-deployment --types=Warning
  echo "Recent pod events:"
  for pod in $(kubectl get pods -l app=py-block3 -o name); do
    kubectl events --for "$pod" --types=Warning
  done
  exit 1
fi
