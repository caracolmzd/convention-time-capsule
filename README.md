# mka-bootstrap

A **solution-independent governance template** for software projects. mka-bootstrap provides documentation taxonomy, milestone workflow, cross-platform agent skills, and deterministic bootstrap scripts for any technology stack.

## Who this repo is for

| Audience | Branch | What to do |
|----------|--------|------------|
| **Maintainers** (template developers) | `main` | Read [ROADMAP.md](ROADMAP.md), work milestones, publish releases |
| **Consumers** (new projects) | `install` (default) | Clone and run `./install.sh` — see [install README template](docs/developer/references/templates/install-README.md) |

This repository **dogfoods its own governance**: the template product on `main` is developed using the same ROADMAP, manifest, skills, and release process it prescribes for every solution repo.

## Documentation map

| Layer | Location | Purpose |
|-------|----------|---------|
| Business requirements | [manifest/](manifest/) | Acceptance criteria, personas, glossary |
| Roadmap | [ROADMAP.md](ROADMAP.md) | Milestone backlog (M-### units of work) |
| Architecture | [docs/developer/architecture/](docs/developer/architecture/) | Solution-independent technical strategy |
| Approach | [docs/developer/approach/](docs/developer/approach/) | Workflow bridges manifest to implementation |
| User docs | [docs/user/](docs/user/) | End-user documentation (most complete layer) |
| Admin docs | [docs/admin/](docs/admin/) | Operations; links to user docs where shared |
| Agent skills | [docs/developer/skills/](docs/developer/skills/) | Canonical cross-platform agent skills |
| Releases | [release/](release/) | Archived milestone close-outs |
| Stakeholder comms | [missives/](missives/) | Chronological decision transcript |

## Maintainer workflow

```bash
git checkout main
# Read ROADMAP.md and manifest/
# Work the current milestone; commit to main
./scripts/validate-governance-structure.sh --context main
./scripts/test/run-local-harness.sh all   # before push
# On sprint close-out:
./scripts/publish-to-install.sh
git push origin main install
```

## Agent contract

See [AGENTS.md](AGENTS.md) for documentation precedence, skill routing, branch context, and invocation shorthand (**Number One**, **make it so**).

## Reference

- Template repo: `git@github.com:caracolazuldev/mka-bootstrap.git`
- Version pin: [.mka-bootstrap](.mka-bootstrap)
