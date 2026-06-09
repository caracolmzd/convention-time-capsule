#!/usr/bin/env bash
# Shared helpers for scripts/google/*.sh

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG_FILE="${REPO_ROOT}/config/google.json"

load_google_config() {
  if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Missing ${CONFIG_FILE} — copy config/google.example.json and fill in IDs." >&2
    echo "See docs/developer/approach/google-workspace-cli.md" >&2
    exit 1
  fi

  local py
  py=$(python3 - <<'PY' "$CONFIG_FILE"
import json, sys
with open(sys.argv[1]) as f:
    c = json.load(f)
for key in ("spreadsheetId", "driveFolderId", "projectId", "conventionId", "schemaVersion"):
    val = c.get(key, "")
    print(f"{key}={val}")
PY
)
  while IFS='=' read -r key val; do
    case "$key" in
      spreadsheetId) SPREADSHEET_ID="$val" ;;
      driveFolderId) DRIVE_FOLDER_ID="$val" ;;
      projectId) PROJECT_ID="$val" ;;
      conventionId) CONVENTION_ID="$val" ;;
      schemaVersion) SCHEMA_VERSION="$val" ;;
    esac
  done <<< "$py"

  if [[ -z "${SPREADSHEET_ID:-}" || "$SPREADSHEET_ID" == YOUR_* ]]; then
    echo "config/google.json: spreadsheetId is not set." >&2
    exit 1
  fi
}

require_gws() {
  if ! command -v gws &>/dev/null; then
    echo "gws not found on PATH." >&2
    echo "Install: brew install googleworkspace-cli  OR  npm install -g @googleworkspace/cli" >&2
    echo "See docs/developer/approach/google-workspace-cli.md" >&2
    exit 2
  fi
}
