#!/bin/bash
set -euo pipefail

count=0
service=block21-heartbeat
heartbeat_mode="$HEARTBEAT_MODE"

if [ "$heartbeat_mode" == "healthy_only" ]; then
  while true; do
    ((++count))
    echo "level=info service=$service event=heartbeat count=$count"
    sleep 15
  done

else
  while true; do
    ((++count))
    if (( count % 10 == 0 )); then
      echo "level=error service=$service event=simulated_failure count=$count reason=every_10th_heartbeat"
    else
      echo "level=info service=$service event=heartbeat count=$count"
    fi
    sleep 15
  done
fi
