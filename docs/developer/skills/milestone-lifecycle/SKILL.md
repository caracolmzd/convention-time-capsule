---
name: milestone-lifecycle
description: Guides milestone scoping, implementation, acceptance, and release close-out. Use when working ROADMAP milestones or cutting releases.
---

# Milestone Lifecycle

## Use when

- Scoping, implementing, accepting, or closing out an M-### milestone.
- Cutting a release or running publish-to-install.

## Workflow

1. Read `docs/developer/approach/milestone-workflow.md` and `manifest/roadmap-processes.md`.
2. Confirm milestone maps to a BR in `manifest/README.md`.
3. **Scope** — write 3–5 paragraph milestone body; link spec to `docs/developer/`.
4. **Implement** — move to In Progress on ROADMAP; run validation as you go.
5. **Accept** — verify deterministic acceptance criteria (scripts, tests).
6. **Close out** — archive in `release/vX.Y.Z.md`; run `publish-to-install.sh` (maintainers).

## mka-bootstrap maintainer context

On `main`, milestones M-001..M-005 track template product work. Sprint close-out publishes to `install`.

## Guardrails

- Milestones must be objectively verifiable when complete.
- Do not skip harness checks before push (`scripts/test/run-local-harness.sh all`).
