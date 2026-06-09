#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DRY_RUN=false
REMOTE="origin"

usage() {
  echo "Usage: $0 [--dry-run] [--remote NAME]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --remote) REMOTE="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1" >&2; usage ;;
  esac
done

cd "$REPO_ROOT"

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$BRANCH" != "main" ]]; then
  echo "ERROR: publish-to-install must run on main (current: $BRANCH)" >&2
  exit 1
fi

"$REPO_ROOT/scripts/validate-governance-structure.sh" --context main
VERSION="$(tr -d '[:space:]' < .mka-bootstrap)"

apply_overlays() {
  cp docs/developer/references/templates/install-README.md README.md
  cp docs/developer/references/templates/solution-ROADMAP.md.stub ROADMAP.md
  cp docs/developer/references/templates/solution-business-requirements.md.stub manifest/business-requirements.md
}

if $DRY_RUN; then
  echo "DRY RUN: would publish mka-bootstrap v${VERSION} to install branch"
  apply_overlays
  "$REPO_ROOT/scripts/validate-governance-structure.sh" --context install || true
  git checkout -- README.md ROADMAP.md manifest/business-requirements.md 2>/dev/null || true
  echo "DRY RUN complete"
  exit 0
fi

if git show-ref --verify --quiet refs/heads/install; then
  git checkout install
  git merge --ff-only main
else
  git checkout -b install main
fi

apply_overlays
git add README.md ROADMAP.md manifest/business-requirements.md
git commit -m "chore(install): publish mka-bootstrap v${VERSION} to install branch" || true

"$REPO_ROOT/scripts/validate-governance-structure.sh" --context install

git checkout main

if git remote get-url "$REMOTE" >/dev/null 2>&1; then
  git push "$REMOTE" main install
fi

echo "Published v${VERSION} to install branch"
