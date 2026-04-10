#!/bin/bash
set -euo pipefail

arg="${1:-}"

kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-configmap.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-service.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-deployment.yaml

timeout="60s"

if [  "$arg" = "restart"  ]; then
  kubectl rollout restart deployment/py-block3-deployment
  timeout="120s"
fi

if kubectl rollout status deployment/py-block3-deployment --timeout="$timeout"; then
  printf '\n=== Rollout succeeded ===\n'
  kubectl get pods -l app=py-block3
  exit 0
else
  printf '\n=== Deployment summary ===\n'
  kubectl get deployment py-block3-deployment

  printf '\n=== Deployment details ===\n'
  kubectl describe deployment py-block3-deployment

  count=0
  printf '\n=== Pods details ===\n'
  for describe_pod in $(kubectl get pods -l app=py-block3 -o name); do
    let count+=1
    printf '\n--- Pod %d: %s ---\n' "$count" "$describe_pod"
    kubectl describe "$describe_pod"
  done

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
