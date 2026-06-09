#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_ONLY=false
CANONICAL="$REPO_ROOT/docs/developer/skills"
STUB_ROOTS=(
  "$REPO_ROOT/.cursor/skills"
  "$REPO_ROOT/.github/skills"
  "$REPO_ROOT/.claude/skills"
  "$REPO_ROOT/.agents/skills"
)

usage() {
  echo "Usage: $0 [--check]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check) CHECK_ONLY=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1" >&2; usage ;;
  esac
done

relative_link() {
  local from_dir="$1"
  local target="$2"
  python3 -c "import os; print(os.path.relpath('$target', '$from_dir'))"
}

generate_stub() {
  local skill_name="$1"
  local stub_dir="$2"
  local canonical="$CANONICAL/$skill_name/SKILL.md"
  local rel
  rel="$(relative_link "$stub_dir" "$canonical")"
  mkdir -p "$stub_dir"
  cat > "$stub_dir/SKILL.md" << EOF
---
name: $skill_name
description: Routing stub — read canonical skill.
---

**Read and follow:** [$skill_name/SKILL.md]($rel)
EOF
}

DRIFT=0

for stub_root in "${STUB_ROOTS[@]}"; do
  skill_dir_name="$(basename "$(dirname "$stub_root")")/$(basename "$stub_root")"
  for skill_path in "$CANONICAL"/*/SKILL.md; do
    [[ -f "$skill_path" ]] || continue
    skill_name="$(basename "$(dirname "$skill_path")")"
    [[ "$skill_name" == "README.md" ]] && continue
    stub_dir="$stub_root/$skill_name"
    if $CHECK_ONLY; then
      if [[ ! -f "$stub_dir/SKILL.md" ]]; then
        echo "DRIFT: missing stub $stub_dir/SKILL.md" >&2
        DRIFT=1
        continue
      fi
      rel="$(relative_link "$stub_dir" "$skill_path")"
      if ! grep -qF "$rel" "$stub_dir/SKILL.md"; then
        echo "DRIFT: stale stub $stub_dir/SKILL.md" >&2
        DRIFT=1
      fi
    else
      generate_stub "$skill_name" "$stub_dir"
    fi
  done
done

if $CHECK_ONLY; then
  if [[ $DRIFT -ne 0 ]]; then
    echo "Skill stub drift detected. Run: scripts/sync-skill-stubs.sh" >&2
    exit 1
  fi
  echo "Skill stubs in sync"
else
  echo "Skill stubs regenerated"
fi
