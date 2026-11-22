# Running-copy notes

Snapshot of the WeChat bridge code running on the Muse VM, as of 2026-11-22.

- Upstream: Mango123-oss/WeChat-bridge (MIT), v2.1, commit b4b9735.
- No upstream tracked file was modified. Local additions in this snapshot:
  - `wechat-bridge.service` — systemd unit (runs daemon.py, Restart=on-failure).
  - `install-service.sh` — idempotent installer for the unit.
- No credentials, state, logs, inbox/outbox, media, or QR images are included
  (upstream .gitignore already excludes state/, logs/, inbox/, outbox/,
  media/, qr/, config.json, fastlane_config.json).

## Deploy

1. Python venv, `pip install -r requirements.txt`
2. `python login.py`, scan the QR code with WeChat
3. `bash install-service.sh` (systemd host) or run `daemon.py` directly

## Caveat: proxy env in the unit

`wechat-bridge.service` sets the egress proxy to
`http://hatch-egress-proxy:3128` with no credentials. That hostname only
resolves on the Muse VM. On any other host, remove or adjust the proxy
lines in the unit, or the daemon will not reach the iLink gateway.

Message triage on the Muse side is done by a separate hook and is not
part of this package.
