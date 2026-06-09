---
name: roadmap-maintenance
description: Maintains ROADMAP.md format, stage markers, and M-### milestone IDs. Use when editing the roadmap or promoting backlog items.
---

# Roadmap Maintenance

## Use when

- Adding, moving, or editing milestones on ROADMAP.md.
- Promoting items from Deep Backlog to scoped milestones.

## ROADMAP format

```markdown
# ── Completed ──
# ── Acceptance ──
# ── Quality Assurance ──
# ── In Progress ──
# ── Sprint ──
# ── Scoping ──

## M-### Milestone title
```

## Rules

1. Milestones are `## M-### Title` only — never epics.
2. Stage markers are `# ── Stage ──` dividers, not milestone headings.
3. Milestones belong to the stage **above** the next marker below them.
4. Order top-to-bottom: Completed → Acceptance → QA → In Progress → Sprint → Scoping.
5. Keep bodies short; link specs to `docs/developer/`.
6. Epics stay in `manifest/Deep-Backlog.md` until scoped as M-###.

## Validation

`scripts/validate-governance-structure.sh --context main` checks M-### presence on maintainer ROADMAP.
