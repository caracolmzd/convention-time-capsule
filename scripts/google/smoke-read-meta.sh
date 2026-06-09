#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

require_gws
load_google_config

echo "Reading Meta!A1:B10 from spreadsheet ${SPREADSHEET_ID} ..." >&2

gws sheets spreadsheets values get \
  --params "{\"spreadsheetId\": \"${SPREADSHEET_ID}\", \"range\": \"Meta!A1:B10\"}"

echo "" >&2
echo "smoke-read-meta: OK" >&2
