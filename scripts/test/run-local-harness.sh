#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCENARIO="all"
KEEP=false

usage() {
  echo "Usage: $0 [validate|bootstrap|publish|all] [--keep]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    validate|bootstrap|publish|all) SCENARIO="$1"; shift ;;
    --keep) KEEP=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown: $1" >&2; usage ;;
  esac
done

LOCAL_TEST="$REPO_ROOT/.local-test"
BOOTSTRAP_BARE="file://$LOCAL_TEST/bare-remotes/mka-bootstrap.git"
SOLUTION_BARE="file://$LOCAL_TEST/bare-remotes/solution.git"
KEEP_FLAG=()
$KEEP && KEEP_FLAG=(--keep)

run_validate() {
  cd "$REPO_ROOT"
  git checkout main 2>/dev/null || true
  "$REPO_ROOT/scripts/sync-skill-stubs.sh" --check
  "$REPO_ROOT/scripts/validate-governance-structure.sh" --context main
}

run_bootstrap() {
  "$REPO_ROOT/scripts/test/setup-bare-remotes.sh" "${KEEP_FLAG[@]}"
  rm -rf "$LOCAL_TEST/install-clone"
  git clone "$BOOTSTRAP_BARE" "$LOCAL_TEST/install-clone" -b install
  cd "$LOCAL_TEST/install-clone"
  ./install.sh --yes --allow-main \
    --solution-url "$SOLUTION_BARE" \
    --project-name "Harness Solution" \
    --description "Disposable test project"
  "$REPO_ROOT/scripts/test/assert-solution-repo.sh" "$LOCAL_TEST/install-clone"
  cd "$REPO_ROOT"
}

run_publish() {
  "$REPO_ROOT/scripts/test/setup-bare-remotes.sh" "${KEEP_FLAG[@]}"
  cd "$REPO_ROOT"
  git checkout main
  git commit --allow-empty -m "test: harness publish marker" || true
  git push "$BOOTSTRAP_BARE" main --force
  git push "$BOOTSTRAP_BARE" main --force

  WORKTREE="$LOCAL_TEST/publish-worktree"
  rm -rf "$WORKTREE"
  git worktree add -B install "$WORKTREE" main
  cp docs/developer/references/templates/install-README.md "$WORKTREE/README.md"
  cp docs/developer/references/templates/solution-ROADMAP.md.stub "$WORKTREE/ROADMAP.md"
  cp docs/developer/references/templates/solution-business-requirements.md.stub "$WORKTREE/manifest/business-requirements.md"
  git -C "$WORKTREE" add README.md ROADMAP.md manifest/business-requirements.md
  git -C "$WORKTREE" commit -m "chore(install): harness publish overlay" || true
  "$WORKTREE/scripts/validate-governance-structure.sh" --context install
  git push "$BOOTSTRAP_BARE" install --force
  git worktree remove "$WORKTREE" --force 2>/dev/null || rm -rf "$WORKTREE"
  git checkout main

  rm -rf "$LOCAL_TEST/install-clone-verify"
  git clone "$BOOTSTRAP_BARE" "$LOCAL_TEST/install-clone-verify" -b install
  grep -q "install.sh" "$LOCAL_TEST/install-clone-verify/README.md" || { echo "install README missing install.sh"; exit 1; }
  grep -q "Scoping" "$LOCAL_TEST/install-clone-verify/ROADMAP.md" || { echo "install ROADMAP missing Scoping"; exit 1; }
  [[ -f "$LOCAL_TEST/install-clone-verify/install.sh" ]] || { echo "install.sh missing on install branch"; exit 1; }
}

case "$SCENARIO" in
  validate) run_validate ;;
  bootstrap) run_validate; run_bootstrap ;;
  publish) run_validate; run_publish ;;
  all) run_validate; run_bootstrap; run_publish ;;
esac

if ! $KEEP; then
  rm -rf "$LOCAL_TEST/install-clone" "$LOCAL_TEST/install-clone-verify" "$LOCAL_TEST/install-worktree" "$LOCAL_TEST/publish-worktree"
fi

echo "Harness scenario '$SCENARIO' passed"
