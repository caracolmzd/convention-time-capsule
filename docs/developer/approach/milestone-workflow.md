# Milestone workflow

End-to-end workflow for M-### milestones from scoping through release.

## 1. Scope

- Confirm milestone maps to a manifest BR (see `manifest/README.md` matrix)
- Body: 3–5 paragraphs max; link full spec to `docs/developer/`
- Verify objectively testable acceptance criteria

## 2. Reconcile

Before moving to **In Progress**:

- Read relevant architecture and approach docs
- Confirm no conflict with manifest acceptance criteria
- Add working spec under `docs/developer/` if needed

## 3. Implement

- Move milestone to **In Progress** on ROADMAP.md
- Work in feature branches or direct commits per team preference
- Run validation and harness checks as you go

## 4. Accept

- Move milestone to **Acceptance** when implementation complete
- Verify acceptance criteria with deterministic checks (scripts, tests)
- Update approach docs if workflow changed

## 5. Close out

- Archive milestone in `release/vX.Y.Z.md` at sprint end
- Remove or move to **Completed** on ROADMAP
- Run `publish-to-install.sh` (mka-bootstrap maintainers)
- Bump `.mka-bootstrap` version pin

## ROADMAP stage order (top to bottom)

Completed → Acceptance → Quality Assurance → In Progress → Sprint → Scoping

Milestones belong to the stage **above** the next marker below them.
