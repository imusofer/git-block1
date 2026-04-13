#!/bin/bash
set -euo pipefail

arg="${1:-}"
namespace="py-block3-namespace"

kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-namespace.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-configmap.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-secret.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-service.yaml
kubectl apply -f ~/devops-git-lab/git-block1/k8s/py-block3-deployment.yaml

timeout="60s"

if [ "$arg" = "restart" ]; then
  kubectl rollout restart deployment/py-block3-deployment -n "$namespace"
  timeout="120s"
fi

if kubectl rollout status deployment/py-block3-deployment -n "$namespace" --timeout="$timeout"; then
  printf '\n=== Rollout succeeded ===\n'
  kubectl get pods -l app=py-block3 -n "$namespace"
  exit 0
else
  printf '\n=== Deployment summary ===\n'
  kubectl get deployment py-block3-deployment -n "$namespace"

  printf '\n=== Deployment details ===\n'
  kubectl describe deployment py-block3-deployment -n "$namespace"

  count=0
  printf '\n=== Pods details ===\n'
  for describe_pod in $(kubectl get pods -l app=py-block3 -o name -n "$namespace"); do
    let count+=1
    printf '\n--- Pod %d: %s ---\n' "$count" "$describe_pod"
    kubectl describe "$describe_pod" -n "$namespace"
  done

  printf '\n=== Pods logs ===\n'
  if kubectl logs -l app=py-block3 -n "$namespace" --tail=5 --prefix=true; then
    :
  else
    printf 'Could not fetch logs\n'
  fi

  printf '\n=== Recent Deployment Warning events ===\n'
  kubectl events --for deployment/py-block3-deployment -n "$namespace" --types=Warning

  printf '\n=== Recent Pod Warning events ===\n'
  for pod in $(kubectl get pods -l app=py-block3 -o name -n "$namespace"); do
    kubectl events --for "$pod" --types=Warning -n "$namespace"
  done
  exit 1
fi
