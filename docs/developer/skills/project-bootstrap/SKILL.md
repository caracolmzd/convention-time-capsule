---
name: project-bootstrap
description: Guides consumer install and maintainer publish workflows. Use when running install.sh, bootstrap-solution.sh, or publish-to-install.sh.
---

# Project Bootstrap

## Use when

- Consumer: bootstrapping a new solution from the `install` branch.
- Maintainer: publishing template updates from `main` to `install`.

## Consumer workflow (install branch)

```bash
./install.sh
# or non-interactive:
./install.sh --yes --solution-url <url> --project-name "My Project"
```

Results:
- `origin` → solution repo
- `project-bootstrap` → mka-bootstrap
- `install.sh` removed
- README from solution-README.md.stub with tokens resolved

## Maintainer workflow (main branch)

```bash
./scripts/publish-to-install.sh
git push origin main install
```

**Never run `./install.sh` on `main`** except in `.local-test/` harness.

## Branch context

| Branch | Role |
|--------|------|
| `main` | Template development; live ROADMAP |
| `install` | Consumer clone surface |
| Solution `main` | Day-to-day project work after install |

## Local testing

`./scripts/test/run-local-harness.sh all` — offline bare-repo validation.
