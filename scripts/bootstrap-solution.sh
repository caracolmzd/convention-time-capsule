#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOLUTION_URL=""
PROJECT_NAME=""
PROJECT_DESCRIPTION=""
ASSUME_YES=false
ALLOW_MAIN=false

usage() {
  echo "Usage: $0 [--solution-url URL] [--project-name NAME] [--description TEXT] [--yes] [--allow-main]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --solution-url) SOLUTION_URL="$2"; shift 2 ;;
    --project-name) PROJECT_NAME="$2"; shift 2 ;;
    --description) PROJECT_DESCRIPTION="$2"; shift 2 ;;
    --yes) ASSUME_YES=true; shift ;;
    --allow-main) ALLOW_MAIN=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1" >&2; usage ;;
  esac
done

cd "$REPO_ROOT"

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
if [[ "$BRANCH" != "install" && "$ALLOW_MAIN" != "true" ]]; then
  echo "ERROR: bootstrap must run on install branch (current: $BRANCH). Use --allow-main for testing." >&2
  exit 1
fi

if [[ -z "$SOLUTION_URL" ]]; then
  read -r -p "Solution repository URL: " SOLUTION_URL
fi
if [[ -z "$PROJECT_NAME" ]]; then
  read -r -p "Project name: " PROJECT_NAME
fi
if [[ -z "$PROJECT_DESCRIPTION" ]]; then
  read -r -p "Project description (optional): " PROJECT_DESCRIPTION
fi

if [[ -z "$SOLUTION_URL" || -z "$PROJECT_NAME" ]]; then
  echo "ERROR: --solution-url and --project-name are required" >&2
  exit 1
fi

if ! $ASSUME_YES; then
  echo "Solution URL: $SOLUTION_URL"
  echo "Project name: $PROJECT_NAME"
  read -r -p "Proceed? [y/N] " confirm
  [[ "$confirm" =~ ^[Yy] ]] || exit 1
fi

MKA_VERSION="$(tr -d '[:space:]' < .mka-bootstrap)"

if git remote get-url origin >/dev/null 2>&1; then
  git remote rename origin project-bootstrap
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote remove origin
fi
git remote add origin "$SOLUTION_URL"

cp docs/developer/references/templates/solution-README.md.stub README.md
cp docs/developer/references/templates/solution-ROADMAP.md.stub ROADMAP.md
cp docs/developer/references/templates/solution-business-requirements.md.stub manifest/business-requirements.md

export PROJECT_NAME PROJECT_DESCRIPTION MKA_VERSION
while IFS= read -r -d '' file; do
  python3 - << 'PY' "$file"
import os, sys
path = sys.argv[1]
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace('{{PROJECT_NAME}}', os.environ.get('PROJECT_NAME', ''))
content = content.replace('{{PROJECT_DESCRIPTION}}', os.environ.get('PROJECT_DESCRIPTION', ''))
content = content.replace('{{MKA_VERSION}}', os.environ.get('MKA_VERSION', ''))
with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
PY
done < <(find README.md ROADMAP.md manifest docs/user docs/admin -type f \( -name '*.md' -o -name '*.stub' \) -print0 2>/dev/null || true)

rm -f install.sh

"$REPO_ROOT/scripts/sync-skill-stubs.sh"
"$REPO_ROOT/scripts/validate-governance-structure.sh" --context solution

git add -A
if git diff --cached --quiet; then
  echo "No changes to commit"
else
  git commit -m "chore: bootstrap solution from mka-bootstrap v${MKA_VERSION}"
fi

git branch -M main
git push -u origin main

echo ""
echo "Bootstrap complete."
echo "  origin             -> $SOLUTION_URL"
echo "  project-bootstrap  -> $(git remote get-url project-bootstrap 2>/dev/null || echo n/a)"
echo "  branch             -> main"
