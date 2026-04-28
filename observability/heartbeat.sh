#!/bin/bash
set -euo pipefail

count=0
service=block21-heartbeat

while true; do
  ((++count))

if (( count % 10 == 0 )); then
  echo "level=error service=$service event=simulated_failure count=$count reason=every_10th_heartbeat"
else
  echo "level=info service=$service event=heartbeat count=$count"
fi

  sleep 1
done
