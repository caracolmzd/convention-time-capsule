#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTEXT="auto"
ERRORS=0

usage() {
  echo "Usage: $0 [--context main|install|solution|auto]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --context) CONTEXT="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1" >&2; usage ;;
  esac
done

fail() {
  echo "VALIDATE FAIL: $*" >&2
  ERRORS=$((ERRORS + 1))
}

require_path() {
  [[ -e "$REPO_ROOT/$1" ]] || fail "Missing required path: $1"
}

require_dir() {
  [[ -d "$REPO_ROOT/$1" ]] || fail "Missing required directory: $1"
}

detect_context() {
  if [[ "$CONTEXT" != "auto" ]]; then
    return
  fi
  if [[ -f "$REPO_ROOT/install.sh" ]]; then
    local branch
    branch="$(git -C "$REPO_ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
    if [[ "$branch" == "install" ]]; then
      CONTEXT="install"
    elif grep -q "mka-bootstrap" "$REPO_ROOT/README.md" 2>/dev/null && grep -qi "maintainer\|template product\|dogfood" "$REPO_ROOT/README.md" 2>/dev/null; then
      CONTEXT="main"
    elif [[ ! -f "$REPO_ROOT/install.sh" ]]; then
      CONTEXT="solution"
    else
      CONTEXT="main"
    fi
  else
    CONTEXT="solution"
  fi
}

check_common_structure() {
  require_path ROADMAP.md
  require_path AGENTS.md
  require_path .mka-bootstrap
  require_dir manifest
  require_dir docs/developer/architecture
  require_dir docs/developer/approach
  require_dir docs/developer/skills
  require_dir docs/user
  require_dir docs/admin
  require_dir release
  require_dir missives
  require_path manifest/business-requirements.md
  require_path manifest/roadmap-processes.md
  require_path docs/developer/architecture/knowledge-management.md
  require_path docs/developer/architecture/documentation-taxonomy.md
}

check_main() {
  if grep -q "Run \`./install.sh\`" "$REPO_ROOT/README.md" && ! grep -qi "maintainer\|template product" "$REPO_ROOT/README.md"; then
    fail "main README appears to be install-only quick-start"
  fi
  if ! grep -qE '^## M-[0-9]{3} ' "$REPO_ROOT/ROADMAP.md"; then
    fail "main ROADMAP must contain ## M-### milestones"
  fi
  require_path scripts/validate-governance-structure.sh
  require_path scripts/sync-skill-stubs.sh
  require_path scripts/bootstrap-solution.sh
  require_path scripts/publish-to-install.sh
}

check_install() {
  if ! grep -q "install.sh" "$REPO_ROOT/README.md"; then
    fail "install README must document ./install.sh"
  fi
  require_path install.sh
}

check_solution() {
  [[ ! -f "$REPO_ROOT/install.sh" ]] || fail "solution repo must not contain install.sh"
  if grep -q '{{PROJECT_NAME}}' "$REPO_ROOT/README.md" 2>/dev/null; then
    fail "Unresolved {{PROJECT_NAME}} token in README.md"
  fi
  if grep -q '{{MKA_VERSION}}' "$REPO_ROOT/README.md" 2>/dev/null; then
    fail "Unresolved {{MKA_VERSION}} token in README.md"
  fi
  if grep -qi "template product" "$REPO_ROOT/README.md" && grep -qi "dogfood" "$REPO_ROOT/README.md"; then
    fail "README appears to be mka-bootstrap maintainer README, not solution README"
  fi
}

check_skills() {
  local skill
  for skill in doc-governance milestone-lifecycle roadmap-maintenance project-bootstrap; do
    require_path "docs/developer/skills/$skill/SKILL.md"
  done
}

detect_context
check_common_structure
check_skills

case "$CONTEXT" in
  main) check_main ;;
  install) check_install ;;
  solution) check_solution ;;
  *) fail "Unknown context: $CONTEXT" ;;
esac

if [[ $ERRORS -gt 0 ]]; then
  echo "Validation failed with $ERRORS error(s) (context=$CONTEXT)" >&2
  exit 1
fi

echo "Validation passed (context=$CONTEXT)"
