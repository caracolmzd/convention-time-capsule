#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

require_gws
load_google_config

TABS=(Meta Submissions Lookups Classifications Roles)

for tab in "${TABS[@]}"; do
  echo "=== ${tab} ===" >&2
  gws sheets spreadsheets values get \
    --params "{\"spreadsheetId\": \"${SPREADSHEET_ID}\", \"range\": \"${tab}!A1:Z1000\"}"
  echo ""
done

echo "inspect-archive: OK" >&2
