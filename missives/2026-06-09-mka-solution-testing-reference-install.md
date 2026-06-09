# 2026-06-09 — mka-solution-testing reference install

**Decision:** Use `mka-solution-testing` as the disposable reference solution for validating the real GitHub consumer install path (M-005 / BR-005).

## GitHub install command

```bash
git clone git@github.com:caracolazuldev/mka-bootstrap.git /home/mzd/Lab/mka-solution-testing
cd /home/mzd/Lab/mka-solution-testing
./install.sh --solution-url git@github.com:caracolazuldev/mka-solution-testing.git \
             --project-name "MKA Solution Testing" \
             --yes
```

## Expected result

- `origin` → mka-solution-testing repo
- `project-bootstrap` → caracolazuldev/mka-bootstrap
- `install.sh` removed; solution README with tokens resolved
- Governance structure passes `validate-governance-structure.sh --context solution`

## Offline testing

Day-to-day validation uses `./scripts/test/run-local-harness.sh all` with local bare remotes under `.local-test/` — no GitHub required.
