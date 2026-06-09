---
name: google-workspace-cli
description: Maintainer Google Workspace operations via gws CLI. Use when bootstrapping Sheets/Drive, inspecting the archive, or running scripts/google/.
---

# Google Workspace CLI

## Use when

- Bootstrapping or verifying Google Cloud backend (M-003)
- Inspecting submissions, lookups, or classifications from the repo (M-010)
- Pulling Sheet data for HTML export (M-009)
- Any maintainer Sheets/Drive task against the Convention Time Capsule backend

## Workflow

1. Read [google-workspace-cli.md](../../approach/google-workspace-cli.md) and [google-workspace-bootstrap.md](../../approach/google-workspace-bootstrap.md).
2. Ensure `gws` is on PATH: `./scripts/google/check-gws.sh`
3. Ensure `config/google.json` exists locally (from `config/google.example.json`).
4. Authenticate: `gws auth login -s drive,sheets` (Desktop OAuth client).
5. Run repo scripts or `gws` commands documented in the approach guide.

## Repo scripts

| Script | Purpose |
|--------|---------|
| `scripts/google/check-gws.sh` | Verify gws installed |
| `scripts/google/smoke-read-meta.sh` | M-003 smoke test |
| `scripts/google/inspect-archive.sh` | M-010 archive dump |

## Guardrails

- Use **Desktop** OAuth for `gws`; **Web** OAuth client is for the GitHub Pages app only.
- Do not commit `config/google.json`, `.env`, or service account keys.
- Wrap Sheet ranges in single quotes in bash (`'Meta!A1:B10'`).
- Upstream full API surface: [github.com/googleworkspace/cli](https://github.com/googleworkspace/cli)
