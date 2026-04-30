# Block 23 Security Notes

## Secret Handling
The service now uses a tracked-template/untracked-real env file pattern, and the secret-like file is restricted and never written to logs.

- `observability/heartbeat.env.example` is tracked to document required keys and format
- `observability/heartbeat.env` is the real local file and is ignored by Git
- `heartbeat.env` is restricted to owner + trusted group access
- `HEARTBEAT_TOKEN` is loaded by the service but must never appear in journald logs

## Least Privilege
The service no longer runs as root and now runs under a dedicated low-privilege service identity.

- Created a dedicated low-privilege system user `heartbeatsvc`
- Created a dedicated group `heartbeatreaders` and added both `imusofer` and `heartbeatsvc` to it
- Made the service run with the `heartbeatsvc` user and `heartbeatreaders` group
- Changed the group ownership of `observability/heartbeat.env` and `observability/heartbeat.sh` to `heartbeatreaders` while keeping `imusofer` as the file owner
- Fixed parent-directory traversal permissions so `heartbeatsvc` could reach the service files without making them world-readable

## Dependency / Runtime Surface
The service depends on both repo-managed artifacts and OS/runtime components, and those two layers need to be maintained and trusted differently.

### Repo-managed
- `heartbeat.sh` contains the service logic
- `healthcheck.sh` contains the local service health-check logic
- `block21-heartbeat.service` is the repo-tracked systemd unit copy
- `heartbeat.env.example` is the tracked template for required env keys

### Local runtime input
- `heartbeat.env` contains the real local secret-like values loaded by the service at runtime.

### OS / runtime-provided
- `/bin/bash`
- `systemd/systemctl`
- `journald/journalctl`
- `Linux users/groups/permissions`

## Current Security Baseline
The service now runs successfully under `heartbeatsvc:heartbeatreaders`, and access to the local secret-like env file is restricted and excluded from Git. 

- `heartbeat.env` is restricted to owner `imusofer` and trusted group `heartbeatreaders`, and is ignored by Git
- `block21-heartbeat.service` runs as `heartbeatsvc:heartbeatreaders` and starts successfully under reduced privilege
- An unrelated local user (`outsider`) cannot read `heartbeat.env`
- `HEARTBEAT_TOKEN` is loaded by the service but is not written to journald logs

## Risks Still Present
This is a stronger local baseline, but it is still not production-grade

- The real env file is still a plain local file under the home-directory path
- No secret rotation
- No central secret store
- No automated dependency/vulnerability scanning
- No integrity checking for local service artifacts
