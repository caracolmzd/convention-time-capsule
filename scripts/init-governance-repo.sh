#!/usr/bin/env bash
set -euo pipefail

# Low-level scaffold helper — mka-bootstrap ships pre-scaffolded.
# This script validates structure and regenerates skill stubs.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

"$REPO_ROOT/scripts/sync-skill-stubs.sh"
"$REPO_ROOT/scripts/validate-governance-structure.sh" --context main
echo "Governance repo initialized/verified."
