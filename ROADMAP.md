# ── Completed ──

## M-001 Manifest foundation

BR-001..BR-008, personas, glossary, Deep Backlog, and BR↔milestone matrix in [manifest/](manifest/).

## M-002 Architecture and style guide

[time-capsule.md](docs/developer/architecture/time-capsule.md), [visual-style.md](docs/developer/architecture/visual-style.md), approach docs linked.

## M-003 Google Workspace bootstrap

Google Cloud project, OAuth clients, Shared drive Sheet/folders, `config/google.json`. Verified with `./scripts/google/smoke-read-meta.sh`.

# ── In Progress ──

## M-004 Static client scaffold (GitHub Pages)

Minimal static shell in [site/](site/): submit and classify placeholders, AFL-CIO visual tokens, GitHub Pages workflow.

**Done when:** Pages deploy succeeds; local preview works with `sync-site-config.sh`.

# ── Sprint ──

## M-005 WASM data layer + Sheets connectivity

WASM module abstracting Sheets/Drive APIs with fixture mode for offline dev.

**Done when:** WASM reads and writes test rows against fixture JSON and live Sheet; vanilla JS UI invokes WASM exports.

## M-006 MVP submission flow

Authenticated submit with prior-entry surfacing per [submission-workflow.md](docs/developer/approach/submission-workflow.md).

**Done when:** BR-001 and BR-002 acceptance criteria verifiable per [mvp-scoping.md](docs/developer/approach/mvp-scoping.md).

## M-007 Team-lead classification UI

Post-submit enrich and classify per BR-003 and BR-005.

## M-008 Document upload

General attachment facility per BR-004.

## M-009 HTML time-capsule generator

Offline-readable HTML export per BR-006 (fast-follow per MVP scoping).

## M-010 Repo inspection tooling

**Done when:** `./scripts/google/inspect-archive.sh` dumps submissions, classifications, and lookups.
