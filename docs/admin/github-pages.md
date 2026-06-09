# GitHub Pages deployment

Operations guide for the static client in [site/](../../site/).

User-facing behavior: [docs/user/README.md](../user/README.md) (to be expanded in M-006).

## Deploy

Pushes to `main` run [.github/workflows/pages.yml](../../.github/workflows/pages.yml).

**Before first deploy:**

1. Enable GitHub Pages: repo **Settings → Pages → Source: GitHub Actions**
2. Set repository **Variables** (Settings → Secrets and variables → Actions → Variables):
   - `GOOGLE_CLIENT_ID` — Web OAuth client ID
   - `GOOGLE_SPREADSHEET_ID`
   - `GOOGLE_DRIVE_FOLDER_ID`
3. Add Web OAuth **authorized JavaScript origin**: `https://<org>.github.io`
4. Add **redirect URI** for the Pages URL (see [google-workspace-bootstrap.md](../developer/approach/google-workspace-bootstrap.md))

The workflow writes `site/config.json` from those variables before upload.

## Local development

```bash
./scripts/sync-site-config.sh   # from config/google.json
cd site && python3 -m http.server 8080
```

`site/config.json` is gitignored; use `site/config.example.json` as the template shape.

## Related

- [visual-style.md](../developer/architecture/visual-style.md)
- [google-workspace-bootstrap.md](../developer/approach/google-workspace-bootstrap.md)
