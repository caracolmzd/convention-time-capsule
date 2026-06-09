# Roadmap processes

## Sprint cadence

- ROADMAP.md holds **current sprint**, **next sprint**, and **scoping** milestones (typically 1–2 future sprints visible).
- Milestones are `# ── Stage ──` grouped top-to-bottom: Completed → Acceptance → Quality Assurance → In Progress → Sprint → Scoping.
- Each milestone is an `## M-### Title` heading; bodies stay short (3–5 paragraphs max). Link full specs to `docs/developer/`.

## Release cadence

- Ideal: one semantic-version release per sprint close-out.
- On close-out: archive completed milestones to `release/vX.Y.Z.md`, bump `.mka-bootstrap`, run `publish-to-install.sh`, push `main` and `install`.
- Tag `vX.Y.Z` on `main`.

## Branch publish (mka-bootstrap specific)

| Branch | Updated when | Content delta |
|--------|--------------|---------------|
| `main` | Every maintainer commit | Live ROADMAP, maintainer README, template BRs |
| `install` | `publish-to-install.sh` | Consumer README overlay, solution ROADMAP stub, solution manifest stub |

## Milestone close-out checklist

1. Milestone acceptance criteria met and verifiable
2. Approach docs updated if workflow changed
3. ROADMAP milestone moved to Completed (or archived in release note)
4. `validate-governance-structure.sh --context main` passes
5. `./scripts/test/run-local-harness.sh all` passes before push
