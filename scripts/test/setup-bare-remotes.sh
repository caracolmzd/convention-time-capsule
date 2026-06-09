#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LOCAL_TEST="$REPO_ROOT/.local-test"
KEEP=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --keep) KEEP=true; shift ;;
    *) shift ;;
  esac
done

if ! $KEEP; then
  rm -rf "$LOCAL_TEST"
fi

mkdir -p "$LOCAL_TEST/bare-remotes" "$LOCAL_TEST/logs"

if [[ ! -d "$LOCAL_TEST/bare-remotes/mka-bootstrap.git" ]]; then
  git init --bare "$LOCAL_TEST/bare-remotes/mka-bootstrap.git"
fi
if [[ ! -d "$LOCAL_TEST/bare-remotes/solution.git" ]]; then
  git init --bare "$LOCAL_TEST/bare-remotes/solution.git"
fi

BOOTSTRAP_BARE="file://$LOCAL_TEST/bare-remotes/mka-bootstrap.git"

# Ensure main has at least one commit
cd "$REPO_ROOT"
if ! git rev-parse HEAD >/dev/null 2>&1; then
  git add -A
  git commit -m "chore: initial mka-bootstrap governance scaffold"
fi

git push "$BOOTSTRAP_BARE" main --force

# Publish install branch to bare remote (local only, no origin push)
"$REPO_ROOT/scripts/publish-to-install.sh" --remote __none__ 2>/dev/null || true

# publish with --remote __none__ won't push - we need local install branch then push to bare
if git show-ref --verify --quiet refs/heads/install; then
  git push "$BOOTSTRAP_BARE" install --force
else
  "$REPO_ROOT/scripts/publish-to-install.sh" --remote __none__ || {
    git checkout -b install main 2>/dev/null || git checkout install
    cp docs/developer/references/templates/install-README.md README.md
    cp docs/developer/references/templates/solution-ROADMAP.md.stub ROADMAP.md
    cp docs/developer/references/templates/solution-business-requirements.md.stub manifest/business-requirements.md
    git add README.md ROADMAP.md manifest/business-requirements.md
    git commit -m "chore(install): seed install branch for harness" || true
    git checkout main
    git push "$BOOTSTRAP_BARE" install --force
  }
fi

git checkout main 2>/dev/null || true

echo "Bare remotes ready at $LOCAL_TEST/bare-remotes/"
