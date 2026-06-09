# Business requirements — mka-bootstrap (maintainer)

## BR-001 Documentation taxonomy enforced

The repository enforces a layered documentation taxonomy (manifest → approach → architecture → user/admin) with deterministic validation on `main`.

**Acceptance:** `validate-governance-structure.sh --context main` exits 0.

## BR-002 Milestone workflow and agent skills routable

Cross-platform agent skills live canonically under `docs/developer/skills/` and are routable from Cursor, GitHub Copilot, Claude Code, and `.agents/` stubs without drift.

**Acceptance:** `sync-skill-stubs.sh --check` exits 0.

## BR-003 Install and bootstrap scripts produce valid solution repo

A consumer clone of the `install` branch can run `./install.sh` and produce a valid solution repository with correct remotes, token substitution, and governance structure.

**Acceptance:** `./scripts/test/run-local-harness.sh bootstrap` exits 0.

## BR-004 Install branch publishable from main

Maintainers on `main` can publish template updates to the consumer-facing `install` branch with correct README and ROADMAP overlays.

**Acceptance:** `./scripts/test/run-local-harness.sh publish` exits 0.

## BR-005 Consumer path verified end-to-end

The full consumer workflow (clone install → install.sh → solution repo) is verified on GitHub using mka-solution-testing as the reference install.

**Acceptance:** Documented in `release/v0.1.0.md` and `missives/`.
