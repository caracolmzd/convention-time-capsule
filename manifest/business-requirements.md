# Business requirements — Convention Time Capsule

Lessons and reflections archive for the **30th AFL-CIO Convention**. Scoped from [missives/2026-06-09-convention-time-capsule-stakeholder-scoping.md](../missives/2026-06-09-convention-time-capsule-stakeholder-scoping.md).

Technical strategy: [docs/developer/architecture/time-capsule.md](../docs/developer/architecture/time-capsule.md). Workflow rationale: [docs/developer/approach/submission-workflow.md](../docs/developer/approach/submission-workflow.md).

## BR-001 Submission capture

Authenticated convention staff can record a lesson learned with enough structure and contact information for follow-up.

**Acceptance:**

- Submitter signs in with org Google SSO; identity is recorded with the submission.
- Submitter can select a knowledge domain and enter free-text lesson content.
- Submitter can provide follow-up contact information (minimum fields defined in MVP scoping).
- A meaningful submission can be completed in under five minutes on desktop or mobile.
- Submission is persisted to the cloud archive without requiring team-lead approval first.

**Spec:** [submission-workflow.md](../docs/developer/approach/submission-workflow.md), [time-capsule.md](../docs/developer/architecture/time-capsule.md)

## BR-002 Prior-submission visibility

Submitters see relevant prior entries while composing a new submission.

**Acceptance:**

- While drafting, submitter sees prior submissions related to the selected knowledge domain (and/or suggested tags).
- Prior entries display enough context to avoid duplicate effort and inform the current write-up.
- Surfacing does not block or delay initial submit for users who skip review.

**Spec:** [submission-workflow.md](../docs/developer/approach/submission-workflow.md)

## BR-003 Team-lead enrichment

Team leads classify and enrich submissions after they are submitted.

**Acceptance:**

- Team lead can assign classification metadata (tags, severity, area, follow-up status) to an existing submission.
- Team lead can add enrichment notes and cross-links without altering the original submitter text.
- Classification is not required before a submission is accepted into the archive.
- Only users with team-lead authorization can perform enrichment actions.

**Spec:** [submission-workflow.md](../docs/developer/approach/submission-workflow.md), [time-capsule.md](../docs/developer/architecture/time-capsule.md)

## BR-004 Document upload

Submitters can attach supporting documents to a submission.

**Acceptance:**

- Submitter can upload at least one file per submission via a general upload facility.
- Attachment is stored in the cloud backend and linked from the submission record.
- Upload failures surface a clear error; successful uploads are confirmable before submit.

**Spec:** [time-capsule.md](../docs/developer/architecture/time-capsule.md)

## BR-005 Learning loop

The archive improves as input is collected: lookups normalize and patterns become visible.

**Acceptance:**

- Category and tag lookup values can be normalized (synonyms merged or mapped to canonical values).
- Submitters and team leads can see recurring themes or patterns derived from the growing corpus.
- Lookup changes do not orphan existing submissions (historical values remain traceable).

**Spec:** [time-capsule.md](../docs/developer/architecture/time-capsule.md), [submission-workflow.md](../docs/developer/approach/submission-workflow.md)

## BR-006 HTML time-capsule export

Maintainers can generate a future-proof HTML archive of the corpus.

**Acceptance:**

- Maintainer can produce a self-contained HTML bundle from cloud-backed data.
- Bundle opens offline and remains readable without the live submission app.
- Export includes generation timestamp, schema/version stamp, and convention identifier (30th).
- Attachment metadata is embedded or linked within the export.

**Spec:** [time-capsule.md](../docs/developer/architecture/time-capsule.md)

## BR-007 Repo inspection

Maintainers can examine cloud-backed submissions and taxonomy from this repository.

**Acceptance:**

- Repo tooling can read submissions, classifications, and lookup tables from the cloud backend.
- Inspection output is sufficient to inform UI field changes, lookup updates, and copy edits.
- Inspection can run without the GitHub Pages app being redeployed for every content review.

**Spec:** [time-capsule.md](../docs/developer/architecture/time-capsule.md), [google-workspace-bootstrap.md](../docs/developer/approach/google-workspace-bootstrap.md)

## BR-008 Longevity

The solution remains usable after years of disuse.

**Acceptance:**

- Client is deployable as static assets (GitHub Pages) with pinned build artifacts.
- Data formats are open and documented (Sheets schema, HTML export).
- Runtime dependencies are minimal (vanilla JavaScript + WASM; no heavy SPA framework).
- A dormant deployment can be revived without proprietary hosting lock-in.

**Spec:** [time-capsule.md](../docs/developer/architecture/time-capsule.md), [visual-style.md](../docs/developer/architecture/visual-style.md)
