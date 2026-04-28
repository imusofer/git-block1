#!/bin/bash
set -euo pipefail

heartbeat_count=0
error_count=0
failure_count=0

if ! systemctl is-active --quiet block21-heartbeat.service; then
  echo "unhealthy: service is not active"
  exit 1
fi

heartbeat_count=$(journalctl -u block21-heartbeat.service --since "1 minute ago" --no-pager | grep -c 'event=heartbeat' || true)
error_count=$(journalctl -u block21-heartbeat.service --since "1 minute ago" --no-pager | grep -c 'level=error' || true)
failure_count=$(journalctl -u block21-heartbeat.service --since "1 minute ago" --no-pager | grep -c 'event=simulated_failure' || true)

if (( heartbeat_count == 0 )); then
  echo "unhealthy: no recent heartbeats"
  exit 1
fi

if (( failure_count > 0 )); then
  echo "unhealthy: failure event"
  exit 1
fi

if (( error_count > 0 )); then
  echo "unhealthy: error event"
  exit 1
fi

echo "healthy: service is active and healthy"
exit 0

