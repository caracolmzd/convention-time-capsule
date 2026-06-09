# Convention Time Capsule

Lessons and Reflections from the 30th AFL-CIO Convention

## Documentation map

| Layer | Location |
|-------|----------|
| Business requirements | [manifest/](manifest/) |
| Roadmap | [ROADMAP.md](ROADMAP.md) |
| Architecture | [docs/developer/architecture/](docs/developer/architecture/) |
| Approach | [docs/developer/approach/](docs/developer/approach/) |
| User docs | [docs/user/](docs/user/) |
| Admin docs | [docs/admin/](docs/admin/) |
| Agent skills | [docs/developer/skills/](docs/developer/skills/) |
| Stakeholder comms | [missives/](missives/) |
| Maintainer toolkit | [docs/developer/approach/google-workspace-cli.md](docs/developer/approach/google-workspace-cli.md) |
| Web app (GitHub Pages) | [site/](site/) |

## Local preview

```bash
./scripts/sync-site-config.sh   # requires config/google.json
cd site && python3 -m http.server 8080
```

Open http://localhost:8080

## Agent contract

See [AGENTS.md](AGENTS.md) for documentation precedence and skill routing.

---

_Bootstrapped from [mka-bootstrap](https://github.com/caracolazuldev/mka-bootstrap) v0.1.0._
