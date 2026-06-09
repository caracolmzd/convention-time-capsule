# Bootstrap a new project

This is the **consumer install guide** for mka-bootstrap. You cloned the `install` branch — follow these steps to create your solution repository.

## 1. Clone (you are here)

```bash
git clone git@github.com:caracolazuldev/mka-bootstrap.git my-project
cd my-project
```

The default branch is `install`.

## 2. Run install

```bash
./install.sh
```

You will be prompted for:

- **Solution repository URL** (required) — empty git remote for your new project
- **Project name** — used in README and manifest
- **Project description** — optional

Non-interactive example:

```bash
./install.sh --yes \
  --solution-url git@github.com:your-org/your-repo.git \
  --project-name "Your Project"
```

## 3. Start developing

After install:

- `origin` → your solution repo
- `project-bootstrap` → mka-bootstrap (for template updates)
- `install.sh` is removed from your solution repo

Read your new `README.md`, `ROADMAP.md`, and `docs/developer/architecture/knowledge-management.md`.

## Need help?

See the template documentation at [caracolazuldev/mka-bootstrap](https://github.com/caracolazuldev/mka-bootstrap) on branch `main`.
