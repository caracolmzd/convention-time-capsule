# Documentation taxonomy

Rules for placing and linking documentation in mka-bootstrap and solution repos bootstrapped from it.

## Placement rules

1. **Business intent** → `manifest/` (never mandate implementation approach in BRs)
2. **Workflow and rationale** → `docs/developer/approach/`
3. **Technical strategy and standards** → `docs/developer/architecture/`
4. **Feature specs (in progress)** → `docs/developer/` (promote when stable)
5. **End-user content** → `docs/user/` (most complete; may be syndicated)
6. **Operations** → `docs/admin/` (link to user docs; avoid duplication)

## ROADMAP format

- Stage markers: `# ── Stage Name ──` (Completed, Acceptance, Quality Assurance, In Progress, Sprint, Scoping)
- Milestones: `## M-### Title` only — no epics in `##` slots
- Epics live in `manifest/Deep-Backlog.md`

## Index maintenance

Every domain directory should have a README or index listing its contents. Cross-link upward to manifest and architecture docs.

## Deduplication

User documentation is authoritative for shared end-user topics. Admin and developer docs **refer** to user docs rather than copying content.

## Branch-specific README

| Context | README source |
|---------|---------------|
| `main` (maintainer) | Root README.md — product vision, contributor guide |
| `install` (consumer) | Overlay from `docs/developer/references/templates/install-README.md` |
| Solution (post-install) | From `solution-README.md.stub` with tokens resolved |

## Validation

Run `scripts/validate-governance-structure.sh --context main|install|solution` to verify structure.
