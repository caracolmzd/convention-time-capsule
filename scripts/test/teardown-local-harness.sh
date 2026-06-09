#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
rm -rf "$REPO_ROOT/.local-test"
echo "Removed .local-test/"
