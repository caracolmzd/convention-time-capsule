#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${1:?Usage: assert-solution-repo.sh REPO_DIR}"
ERRORS=0

fail() { echo "ASSERT FAIL: $*" >&2; ERRORS=$((ERRORS + 1)); }

[[ ! -f "$REPO_DIR/install.sh" ]] || fail "install.sh must be absent in solution repo"

if grep -q '{{PROJECT_NAME}}' "$REPO_DIR/README.md" 2>/dev/null; then
  fail "Unresolved {{PROJECT_NAME}} in README"
fi

git -C "$REPO_DIR" remote get-url origin >/dev/null 2>&1 || fail "origin remote missing"
git -C "$REPO_DIR" remote get-url project-bootstrap >/dev/null 2>&1 || fail "project-bootstrap remote missing"

for dir in manifest docs/developer docs/user docs/admin release; do
  [[ -d "$REPO_DIR/$dir" ]] || fail "Missing directory: $dir"
done

"$REPO_DIR/scripts/validate-governance-structure.sh" --context solution

if [[ $ERRORS -gt 0 ]]; then
  exit 1
fi
echo "Solution repo assertions passed"
