---
name: doc-governance
description: Maintains documentation taxonomy and layer placement. Use when creating or editing manifest, approach, architecture, user, or admin docs.
---

# Doc Governance

## Use when

- Adding or editing documentation anywhere in the repository.

## Workflow

1. Read `manifest/business-requirements.md` and `manifest/personas.md`.
2. Read `docs/developer/architecture/knowledge-management.md` and `documentation-taxonomy.md`.
3. Place content in the correct layer:
   - **manifest/** — business intent, acceptance criteria
   - **docs/developer/approach/** — workflow and rationale
   - **docs/developer/architecture/** — solution-independent strategy
   - **docs/user/** — complete end-user content
   - **docs/admin/** — operations; link to user docs
4. Update indexes and cross-links.
5. Run `scripts/validate-governance-structure.sh --context main`.

## Guardrails

- Do not duplicate user documentation in admin or developer docs — link instead.
- Epics belong in `manifest/Deep-Backlog.md`, not ROADMAP `##` slots.
- Keep milestone bodies on ROADMAP short; link full specs to `docs/developer/`.
