# Working document promotion

Checklist for graduating an in-progress spec from `docs/developer/` working status to a stable home.

## When to promote

- Acceptance criteria are defined and testable
- Content is no longer expected to change daily
- Links from manifest BRs or ROADMAP milestones exist

## Promotion checklist

1. **Classify** — approach (rationale), architecture (constraints), or user/admin (audience-facing)?
2. **Move or merge** — relocate to the correct layer; do not leave duplicate copies
3. **Update indexes** — domain README, manifest links, ROADMAP milestone body
4. **Dedupe** — if user-facing, ensure admin/dev docs link rather than repeat
5. **Validate** — `validate-governance-structure.sh --context main`

## Naming

Use kebab-case filenames. Prefer descriptive names over ticket IDs in filenames.

## Anti-patterns

- Leaving stale working copies after promotion
- Putting epics directly on ROADMAP as `##` headings
- Duplicating user documentation in admin docs
