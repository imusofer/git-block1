# Block 21 Heartbeat Service Runbook

## Service Overview
`block21-heartbeat.service` is a local systemd service used for observability practice.
It runs `heartbeat.sh`, emits structured-ish logs to journald, and can intentionally emit simulated error events for health-check testing.

## Key Files
- `/etc/systemd/system/block21-heartbeat.service` — installed systemd unit file
- `observability/block21-heartbeat.service` — repo-tracked copy of the systemd unit
- `observability/heartbeat.sh` — heartbeat script that emits structured-ish logs and simulated failures
- `observability/healthcheck.sh` — health-check script for service state and recent logs
- `observability/block21-heartbeat-runbook.md` — operational runbook

## Health Check
Run:

`./observability/healthcheck.sh`

Healthy expected output:

`healthy: service is active and healthy`

Healthy expected exit code:

`0`

Unhealthy expected output:

`unhealthy: failure event`

Unhealthy expected exit code:

`1`

## Inspect Service State
- `systemctl is-active block21-heartbeat.service`
- `systemctl status block21-heartbeat.service --no-pager`
- `systemctl --failed`

## Inspect Logs
- `journalctl -u block21-heartbeat.service -n 20 --no-pager`
- `journalctl -u block21-heartbeat.service --since "1 minute ago" --no-pager`
- `journalctl -u block21-heartbeat.service -n 100 --no-pager | grep 'level=error'`
- `journalctl -u block21-heartbeat.service -n 100 --no-pager | grep 'event=simulated_failure'`

## Known Failure Modes
### Bad ExecStart path
Symptom: service enters `failed` state.

Evidence:
- `systemctl is-active block21-heartbeat.service` returns `failed`
- `systemctl status block21-heartbeat.service --no-pager` shows `status=203/EXEC`
- `systemctl --failed` lists `block21-heartbeat.service`

Cause: the unit file points `ExecStart` to a missing or non-executable script.

### Simulated error logs
Symptom: service stays active, but health check returns unhealthy.

Evidence:
- recent journal logs contain `level=error`
- recent journal logs contain `event=simulated_failure`
- `./observability/healthcheck.sh` exits with code `1`

Cause: the heartbeat script intentionally emits a simulated failure every 10th heartbeat.

## Recovery Steps
For a bad `ExecStart` path:
1. Fix `ExecStart` in `/etc/systemd/system/block21-heartbeat.service`.
2. Run `sudo systemctl daemon-reload`.
3. Run `sudo systemctl reset-failed block21-heartbeat.service`.
4. Run `sudo systemctl restart block21-heartbeat.service`.
5. Verify the service is active.

For simulated error logs:
1. Edit `observability/heartbeat.sh`.
2. Disable the simulated error branch if testing healthy behavior.
3. Restart the service.
4. Run the health check again.

## Final Verification
- `systemctl is-active block21-heartbeat.service`
- `systemctl status block21-heartbeat.service --no-pager`
- `journalctl -u block21-heartbeat.service -n 20 --no-pager`
- `./observability/healthcheck.sh`
- `echo $?`
