# Agent Operating Contract

## Mission

Support mka-bootstrap and solution repos bootstrapped from it with clear governance, milestone-driven workflow, and cross-platform skill routing.

## Documentation precedence

1. `manifest/` (business requirements, personas, roadmap processes)
2. `docs/developer/approach/`
3. `docs/developer/architecture/`
4. `docs/user/` (most complete for end-user topics)
5. `docs/admin/` (operations; link to user docs)

## Required reading order (new tasks)

1. `manifest/business-requirements.md`
2. `manifest/personas.md`
3. `docs/developer/architecture/knowledge-management.md`
4. Active milestone on `ROADMAP.md`

## Skills routing

- **Canonical skills:** `docs/developer/skills/` (see `docs/developer/skills/README.md`)
- **Platform stubs:** `.cursor/skills/`, `.github/skills/`, `.claude/skills/`, `.agents/skills/` — routing only
- Before editing docs: read `doc-governance/SKILL.md`
- Before ROADMAP edits: read `roadmap-maintenance/SKILL.md`
- Before milestone or release work: read `milestone-lifecycle/SKILL.md`
- Before install or publish: read `project-bootstrap/SKILL.md`
- Regenerate stubs: `scripts/sync-skill-stubs.sh`; verify: `scripts/sync-skill-stubs.sh --check`

## Branch context

| Branch | Agent behavior |
|--------|----------------|
| `main` | Follow ROADMAP milestones for template work; do not run `./install.sh` except in tests |
| `install` | Consumer install context; `./install.sh` is valid |
| Solution repo | Follow solution ROADMAP; `project-bootstrap` remote for template updates |

## Agent invocation conventions

| Convention | Meaning |
|--------------|---------|
| **Number One** | Nickname for the primary coding agent working in this repository |
| **make it so** | Execute the active plan — switch to implementation mode, work todos in order, run harness checks |
| **make it so, number one** | Same as **make it so** |

When a maintainer says **make it so**:

1. Treat it as authorization to build the active Governance Template Plan (or agreed milestone scope)
2. Work through plan todos in implementation order
3. Run `./scripts/test/run-local-harness.sh` at plan checkpoints
4. Do not re-enter extended planning unless blocked or redirected

## ROADMAP marker rule

Stage markers are `# ── Stage ──` dividers. Milestones (`## M-###`) belong to the stage **above** the next marker below.

Order top-to-bottom: Completed → Acceptance → Quality Assurance → In Progress → Sprint → Scoping.

Epics live in `manifest/Deep-Backlog.md` — never as ROADMAP `##` headings.

## Neutrality rule

Documentation and skills in mka-bootstrap are **stack-agnostic**. Do not assume APEX, Node, or other stack unless working in a stack-specific skill pack.
