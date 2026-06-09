# MVP scoping

Decision log bridging manifest BRs to phased ROADMAP milestones. Answer these questions before cutting **M-006** scope.

Source: [missives/2026-06-09-convention-time-capsule-stakeholder-scoping.md](../../../missives/2026-06-09-convention-time-capsule-stakeholder-scoping.md). BRs: [business-requirements.md](../../../manifest/business-requirements.md).

## How to use this document

Record stakeholder answers in the **Decision** column as they are confirmed. Unanswered items block final MVP scope for M-006–M-008.

---

## Audience and timing


| #   | Question                                                                          | Decision                                               |
| --- | --------------------------------------------------------------------------------- | ------------------------------------------------------ |
| 1   | When should submission open — during convention week only, or weeks before/after? | *Immediately and until closed.*                        |
| 2   | Who is the initial team-lead set (names or Google Group)?                         | *Defer*                                                |
| 3   | Roughly how many submitters and submissions are expected?                         | *~50 submitters and possibly 1,000-2,000 submissions.* |


## MVP feature cut


| #   | Question                                                                                                      | Decision                                                                                |
| --- | ------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| 4   | For v1, is **submit + view prior entries** enough, or must team-lead classification ship in the same release? | *submit and view prior entries. We will build the list of teams from user submissions.* |
| 5   | Is **document upload** required for MVP, or can v1 be text-only?                                              | *required for MVP.*                                                                     |
| 6   | Is **similarity search** required for MVP, or is a simple domain/tag filter acceptable?                       | *domain/tag filter acceptable.*                                                         |
| 7   | Is **HTML export** required for MVP, or acceptable as a fast-follow after the convention?                     | *fast-follow-up.*                                                                       |


## Data and privacy


| #   | Question                                                                       | Decision                                                                                                     |
| --- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| 8   | What follow-up contact fields are required (email only, phone, org/role)?      | *email only.*                                                                                                |
| 9   | Retention/redaction policy for PII — keep indefinitely, or redact on export?   | *keep indefinitely since this is an internal app.*                                                           |
| 10  | Any submissions that must stay team-lead-only (sensitive safety/morale items)? | *no, submissions should be un-restricted. team-leads will have capability to add meta-data used for export.* |


## Google / org constraints


| #   | Question                                                                            | Decision                         |
| --- | ----------------------------------------------------------------------------------- | -------------------------------- |
| 11  | Confirm Workspace domain restriction for SSO (e.g. `@aflcio.org` only)?             | *@aflcio.org only ("Internal")*  |
| 12  | Shared Drive ownership — which team/account owns the Sheet and folder?              | *mdaryabeygi@aflcio.org*         |
| 13  | Service account acceptable for maintainer export scripts, or OAuth-only everywhere? | *Service account is acceptable.* |


## Branding


| #   | Question                                                                                                | Decision                              |
| --- | ------------------------------------------------------------------------------------------------------- | ------------------------------------- |
| 14  | Full AFL-CIO header/footer chrome, or lightweight convention-branded shell?                             | *lightweigh convention-branded shell* |
| 15  | Is linking back to [aflcio.org/convention-info](https://aflcio.org/convention-info) required in the UI? | *no*                                  |


---

## Proposed MVP tiers (draft)

Use after questions 4–7 are answered:


| Tier      | Milestones     | BRs                    | Minimum capability                                         |
| --------- | -------------- | ---------------------- | ---------------------------------------------------------- |
| **MVP-A** | M-004–M-006    | BR-001, BR-002, BR-008 | SSO submit, domain filter for prior entries, static deploy |
| **MVP-B** | + M-007        | BR-003, BR-005         | Team-lead classification                                   |
| **MVP-C** | + M-008        | BR-004                 | Document upload                                            |
| **MVP-D** | + M-009, M-010 | BR-006, BR-007         | HTML export and repo inspection                            |


## Related

- [google-workspace-bootstrap.md](google-workspace-bootstrap.md)
- [submission-workflow.md](submission-workflow.md)
- [ROADMAP.md](../../../ROADMAP.md)

