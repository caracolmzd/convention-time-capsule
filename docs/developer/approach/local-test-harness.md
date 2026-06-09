# Local test harness

Offline validation of install and publish workflows using disposable checkouts under `.local-test/` (gitignored).

## Prerequisites

- Bash, git
- Run from repository root on `main`
- No network or GitHub access required

## Quick start

```bash
./scripts/test/run-local-harness.sh all
```

## Scenarios

| Command | Validates |
|---------|-----------|
| `validate` | Structure + skill stub checks |
| `bootstrap` | install clone → `./install.sh` → solution bare repo |
| `publish` | main → install publish with overlays |
| `all` | Full suite |

## Debug with --keep

```bash
./scripts/test/run-local-harness.sh bootstrap --keep
# Inspect .local-test/install-clone/ and bare remotes
./scripts/test/teardown-local-harness.sh   # when done
```

## Layout

```
.local-test/
├── bare-remotes/
│   ├── mka-bootstrap.git/
│   └── solution.git/
├── install-clone/
└── logs/
```

## When to run

- After changing bootstrap or publish scripts
- Before pushing to GitHub
- After editing skills (also run `sync-skill-stubs.sh --check`)
