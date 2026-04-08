#!/bin/bash
set -euo pipefail

kubectl apply -f k8s/py-block3-service.yaml
kubectl apply -f k8s/py-block3-deployment.yaml
kubectl rollout status deployment/py-block3-deployment
kubectl get pods -l app=py-block3
