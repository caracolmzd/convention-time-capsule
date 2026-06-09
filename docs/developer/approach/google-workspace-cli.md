# Google Workspace CLI (`gws`)

Maintainer toolkit for Sheets and Drive operations in this repo. Uses [googleworkspace/cli](https://github.com/googleworkspace/cli).

> **Not** an officially supported Google product (per upstream).

Architecture: [time-capsule.md](../architecture/time-capsule.md). Bootstrap: [google-workspace-bootstrap.md](google-workspace-bootstrap.md).

## Role

| Layer | Tool |
|-------|------|
| GitHub Pages app (submitters) | Web OAuth client + WASM |
| Maintainer repo (inspect, bootstrap, export data) | **gws** + [scripts/google/](../../../scripts/google/) |

`gws` does not replace the browser client. Maintainers use a **Desktop** OAuth client; the Pages app uses a separate **Web** OAuth client in the same GCP project.

## Install

Pick one (document only — nothing vendored in this repo):

```bash
# Homebrew (macOS / Linux)
brew install googleworkspace-cli

# npm
npm install -g @googleworkspace/cli

# Or download a release binary
# https://github.com/googleworkspace/cli/releases
```

Prerequisites: Node.js 18+ for npm path; `jq` optional (repo scripts use Python 3 for config).

## Authenticate

### Fast path (gcloud installed)

```bash
gws auth setup
gws auth login -s drive,sheets
```

### Manual path (recommended for org projects)

1. In [Google Cloud Console](https://console.cloud.google.com/), create OAuth client type **Desktop app**.
2. Download JSON to `~/.config/gws/client_secret.json`.
3. Add your account as a **Test user** on the OAuth consent screen (if app is in testing mode).
4. Login with limited scopes (unverified apps cap at ~25 scopes):

```bash
gws auth login -s drive,sheets
```

Do **not** use the full `recommended` scope preset in testing mode.

### Service account (optional)

```bash
export GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE=/path/to/service-account.json
```

See [.env.example](../../../.env.example) for all `GOOGLE_WORKSPACE_CLI_*` variables.

## Repository configuration

```bash
cp config/google.example.json config/google.json
# Edit: spreadsheetId, driveFolderId, projectId, clientId (Web client for Pages)
```

Optional `.env` for gws (see `.env.example`). Auth precedence (upstream): token → credentials file → encrypted login store.

## Convention commands

Replace `SPREADSHEET_ID` with value from `config/google.json`.

### Smoke read Meta tab (M-003)

```bash
./scripts/google/smoke-read-meta.sh
```

Or directly:

```bash
gws sheets spreadsheets values get \
  --params '{"spreadsheetId": "SPREADSHEET_ID", "range": "Meta!A1:B10"}'
```

### Inspect archive (M-010)

```bash
./scripts/google/inspect-archive.sh
```

### Helpers

```bash
# Read submissions
gws sheets +read --spreadsheet SPREADSHEET_ID --range 'Submissions!A1:Z500'

# Append a lookup row
gws sheets +append --spreadsheet SPREADSHEET_ID --range 'Lookups!A1' --values 'Technical systems and integrations,domain,,1'

# List Drive folder contents
gws drive files list --params '{"q": "'\''FOLDER_ID'\'' in parents", "pageSize": 20}'

# Upload attachment
gws drive +upload ./local-file.pdf --name "report.pdf"
```

Wrap Sheet ranges in **single quotes** in bash (`Sheet1!A1:C10` — `!` is history expansion).

### Create resources (bootstrap)

```bash
gws sheets spreadsheets create --json '{"properties": {"title": "Convention Time Capsule"}}'

gws drive files create --json '{"name": "Convention-Time-Capsule", "mimeType": "application/vnd.google-apps.folder"}'
```

## Repo scripts

| Script | Purpose |
|--------|---------|
| [check-gws.sh](../../../scripts/google/check-gws.sh) | Assert `gws` on PATH |
| [smoke-read-meta.sh](../../../scripts/google/smoke-read-meta.sh) | M-003 verification |
| [inspect-archive.sh](../../../scripts/google/inspect-archive.sh) | Dump Submissions, Lookups, Classifications |

## Exit codes (gws)

| Code | Meaning |
|------|---------|
| `0` | Success |
| `1` | API error |
| `2` | Auth error |
| `3` | Validation error |

Repo scripts exit `2` when `gws` is missing; propagate gws exit codes otherwise.

## AI agent skills (upstream)

Optional install of upstream gws skills:

```bash
npx skills add https://github.com/googleworkspace/cli
```

Full index: [github.com/googleworkspace/cli/docs/skills.md](https://github.com/googleworkspace/cli/blob/main/docs/skills.md).

This repo also ships a routing stub: [google-workspace-cli/SKILL.md](../skills/google-workspace-cli/SKILL.md).

## Related

- [google-workspace-bootstrap.md](google-workspace-bootstrap.md)
- [mvp-scoping.md](mvp-scoping.md)
