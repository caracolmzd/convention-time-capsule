# Personas

## Maintainer

Develops the mka-bootstrap template on `main`. Works milestones from ROADMAP.md, updates manifest and architecture docs, runs the local test harness before push, and publishes to `install` at sprint close-out.

**Goals:** Reliable governance tooling; dogfooded workflow; stack-agnostic template.

## Consumer

Bootstraps a new solution repository from the `install` branch. Runs `./install.sh`, provides a solution remote URL, and receives a governed project scaffold with `origin` (solution) and `project-bootstrap` (template updates).

**Goals:** Fast project setup; consistent documentation architecture; agent-ready skills.

## Number One (agent)

Primary coding agent working in this repository (Cursor, Copilot, Claude Code, etc.). Follows AGENTS.md, reads canonical skills before acting, and executes the active plan when told **make it so**.
