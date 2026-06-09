# Agent skills (canonical)

Cross-platform agent skills for mka-bootstrap and solution repos. **Canonical location:** `docs/developer/skills/`.

Platform folders (`.cursor/skills/`, `.github/skills/`, `.claude/skills/`, `.agents/skills/`) contain routing stubs only. Regenerate with `scripts/sync-skill-stubs.sh`.

| Skill | Trigger |
|-------|---------|
| [doc-governance](doc-governance/SKILL.md) | Editing any documentation |
| [milestone-lifecycle](milestone-lifecycle/SKILL.md) | Milestone work or releases |
| [roadmap-maintenance](roadmap-maintenance/SKILL.md) | ROADMAP.md edits |
| [project-bootstrap](project-bootstrap/SKILL.md) | install.sh or publish workflows |
| [google-workspace-cli](google-workspace-cli/SKILL.md) | Maintainer gws / Sheets / Drive operations |

Stack-specific skills may be added as subdirectories here in future releases.
