#!/usr/bin/env bash
# Copy public client config from config/google.json to site/config.json for local dev and Pages deploy.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${REPO_ROOT}/config/google.json"
DEST="${REPO_ROOT}/site/config.json"

if [[ ! -f "$SRC" ]]; then
  echo "Missing ${SRC} — copy from config/google.example.json" >&2
  exit 1
fi

python3 - <<'PY' "$SRC" "$DEST"
import json, sys
src, dest = sys.argv[1], sys.argv[2]
with open(src) as f:
    c = json.load(f)
public = {
    "clientId": c["clientId"],
    "spreadsheetId": c["spreadsheetId"],
    "driveFolderId": c["driveFolderId"],
    "conventionId": c.get("conventionId", "30th"),
    "schemaVersion": c.get("schemaVersion", "1"),
}
with open(dest, "w") as f:
    json.dump(public, f, indent=2)
    f.write("\n")
print(f"Wrote {dest}")
PY
