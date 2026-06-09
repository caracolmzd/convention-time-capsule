Request: Allow outbound HTTPS from developer workstations (WSL/Linux) to Google Workspace APIs for project convention-staff-time-capsule.

Tool: gws (Google Workspace CLI) — maintainer scripts only; calls Google APIs over TLS 443.

Allowlist (minimum):

*.googleapis.com (or at least):
sheets.googleapis.com
drive.googleapis.com
oauth2.googleapis.com
www.googleapis.com
accounts.google.com (if OAuth login is used from browser on same machine)
Port: 443/tcp outbound only. No inbound rules.

Auth: Service account in GCP project convention-staff-time-capsule; data in org Google Shared drive.

Symptom on VPN: connection timed out to https://sheets.googleapis.com/v4/spreadsheets. Works with VPN off.

Not needed: Inbound access, static IPs from Google, or VPN split-tunnel exceptions for GitHub (separate from this).

Optional tighter ask: Split-tunnel or bypass for *.googleapis.com and oauth2.googleapis.com for dev hosts running this project.

Test after change:


curl -I --max-time 10 https://sheets.googleapis.com
curl -I --max-time 10 https://oauth2.googleapis.com/token
Both must return HTTP headers, not timeout.