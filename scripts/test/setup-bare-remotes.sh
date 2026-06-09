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

git init --bare "$LOCAL_TEST/bare-remotes/mka-bootstrap.git" 2>/dev/null || true
git init --bare "$LOCAL_TEST/bare-remotes/solution.git" 2>/dev/null || true

BOOTSTRAP_BARE="file://$LOCAL_TEST/bare-remotes/mka-bootstrap.git"

cd "$REPO_ROOT"
git checkout main

git push "$BOOTSTRAP_BARE" main --force

# Build install branch in a temp worktree to avoid disturbing maintainer checkout
WORKTREE="$LOCAL_TEST/install-worktree"
rm -rf "$WORKTREE"
git worktree add -B install "$WORKTREE" main
cp docs/developer/references/templates/install-README.md "$WORKTREE/README.md"
cp docs/developer/references/templates/solution-ROADMAP.md.stub "$WORKTREE/ROADMAP.md"
cp docs/developer/references/templates/solution-business-requirements.md.stub "$WORKTREE/manifest/business-requirements.md"
git -C "$WORKTREE" add README.md ROADMAP.md manifest/business-requirements.md
git -C "$WORKTREE" commit -m "chore(install): seed install branch for harness" || true
git push "$BOOTSTRAP_BARE" install --force
git worktree remove "$WORKTREE" --force 2>/dev/null || rm -rf "$WORKTREE"

git checkout main

echo "Bare remotes ready at $LOCAL_TEST/bare-remotes/"
