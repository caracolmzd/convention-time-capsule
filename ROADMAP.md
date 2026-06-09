# ── Scoping ──

## M-001 Establish documentation taxonomy, indexes, and Deep Backlog

Establish the documentation taxonomy, manifest skeleton, architecture and approach docs, and Deep Backlog. Acceptance: `validate-governance-structure.sh --context main` passes.

## M-002 Author governance skills, platform stubs, and AGENTS.md

Author four canonical governance skills, platform routing stubs, AGENTS.md, and Cursor rules. Acceptance: `sync-skill-stubs.sh --check` passes.

## M-003 Implement install.sh, bootstrap-solution.sh, init, validate, sync-skill-stubs

Implement deterministic init, validate, bootstrap, and install scripts plus the offline test harness bootstrap scenario. Acceptance: `./scripts/test/run-local-harness.sh bootstrap` passes.

## M-004 Implement publish-to-install.sh; establish main/install branch model

Implement publish-to-install with install-branch overlays. Acceptance: `./scripts/test/run-local-harness.sh publish` passes.

## M-005 Publish v0.1.0; dogfood install path → mka-solution-testing

Close milestones M-001 through M-005, publish release/v0.1.0.md, tag v0.1.0, and document mka-solution-testing reference install.
