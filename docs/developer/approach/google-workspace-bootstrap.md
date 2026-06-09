# Google Workspace bootstrap

Checklist for creating the Google Cloud backend before implementation milestones M-003 and beyond. Architecture: [time-capsule.md](../architecture/time-capsule.md). Maintainer CLI: [google-workspace-cli.md](google-workspace-cli.md).

**M-003 is blocked** until a maintainer completes these steps and records non-secret IDs in repo configuration.

## Dual OAuth clients

Same GCP project, **two client types**:


| Client         | Type                | Used by                                     |
| -------------- | ------------------- | ------------------------------------------- |
| Pages app      | **Web application** | Submitters in browser (GitHub Pages + WASM) |
| Maintainer CLI | **Desktop app**     | `gws auth login` on maintainer machine      |


Do not reuse the Desktop client JSON for the browser app.

## Prerequisites

- Google Workspace admin access (or delegate who can approve OAuth consent)
- GitHub Pages URL known (e.g. `https://<org>.github.io/convention-time-capsule/`)
- Shared Drive or folder owner identified (see [mvp-scoping.md](mvp-scoping.md))
- `[gws](https://github.com/googleworkspace/cli)` installed (see [google-workspace-cli.md](google-workspace-cli.md))

## Checklist

### 1. Google Cloud project

- [x] Create project (suggested name: `convention-time-capsule`)
- [x] Note **Project ID [convention-staff-time-capsule]** and **Project number [318286883402]**

**gws-assisted:** `gws auth setup` (requires `gcloud` CLI) walks through project and API enablement.

### 2. Enable APIs

- [x] [Google Sheets API](https://console.cloud.google.com/apis/library/sheets.googleapis.com)
- [x] [Google Drive API](https://console.cloud.google.com/apis/library/drive.googleapis.com)

**gws-assisted:** `gws auth setup` enables required APIs when using automated setup.

### 3. OAuth consent screen

- [x] User type: **Internal** (Workspace org only), unless external testers are required
- [x] App name: Convention Time Capsule
- [x] Scopes (minimum):
  - `https://www.googleapis.com/auth/spreadsheets`
  - `https://www.googleapis.com/auth/drive.file` (or `drive` if broader folder access needed)
- [x] Support email and developer contact set
- [ ] Add maintainer accounts as **Test users** if app is in testing mode (required for `gws auth login`)

### 4. OAuth 2.0 Web client (Pages app)

- [x] Application type: **Web application**
- [x] Authorized JavaScript origins:
  - `http://localhost:8080` (or local dev port)
  - `https://<org>.github.io`
- [x] Authorized redirect URIs: match OAuth library / code flow paths used by static client
- [x] Copy **Client ID** into `config/google.json` (public in repo config template)

### 4b. OAuth 2.0 Desktop client (maintainer `gws`)

- [x] Application type: **Desktop app**
- [x] Download client JSON to `~/.config/gws/client_secret.json`
- [x] Run `gws auth login -s drive,sheets` (not the full `recommended` scope preset)

### 5. Spreadsheet

- [x] Create Google Sheet per [time-capsule.md](../architecture/time-capsule.md) tabs: `Meta`, `Submissions`, `Lookups`, `Classifications`, `Roles`
- [x] Seed `Lookups` with six knowledge domains
- [x] Set `Meta!convention_id` = `30th`, `schema_version` = `1`
- [ ] Share Sheet with team-lead accounts and service account (if used)
- [x] Record **Spreadsheet ID** in `config/google.json`

**gws-assisted:**

```bash
gws sheets spreadsheets create --json '{"properties": {"title": "Convention Time Capsule"}}'
```

### 6. Drive folder

- [x] Create folder `Convention-Time-Capsule` with subfolders `attachments/`, `exports/`
- [ ] Share with same principals as Sheet
- [x] Record **Folder ID** in `config/google.json`

**gws-assisted:**

```bash
gws drive files create --json '{"name": "Convention-Time-Capsule", "mimeType": "application/vnd.google-apps.folder"}'
```

### 7. Team-lead authorization

- [ ] Decide model (Sheet `Roles` tab, Google Group, or config allowlist) — document in [mvp-scoping.md](mvp-scoping.md)
- [ ] Seed initial team-lead emails in `Roles` tab if Sheet-backed

### 8. Service account (optional)

- [x] Create service account for headless export/inspection
- [x] Grant access to Sheet and Drive folder
- [x] Set `GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE` in `.env` (see [.env.example](../../../.env.example))

### 9. Repository configuration

- [x] `config/google.example.json` with placeholder IDs
- [x] `.env.example` for gws environment variables
- [x] `.env` and `config/google.json` gitignored
- [x] Maintainer copies examples to `config/google.json` and `.env` locally

## Example `config/google.example.json`

```json
{
  "clientId": "YOUR_OAUTH_CLIENT_ID.apps.googleusercontent.com",
  "projectId": "convention-staff-time-capsule",
  "spreadsheetId": "YOUR_SPREADSHEET_ID",
  "driveFolderId": "YOUR_DRIVE_FOLDER_ID",
  "conventionId": "30th",
  "schemaVersion": "1"
}
```

## Verification

After configuration:

1. Maintainer can open Sheet and Drive folder with intended accounts
2. Web OAuth client origins include GitHub Pages URL
3. `config/google.json` (local, gitignored) populated from examples
4. `./scripts/google/check-gws.sh` passes
5. `./scripts/google/smoke-read-meta.sh` reads `Meta` tab (M-003 acceptance)

## Related

- [google-workspace-cli.md](google-workspace-cli.md) — install, auth, convention commands
- [mvp-scoping.md](mvp-scoping.md) — org constraints and ownership questions
- [time-capsule.md](../architecture/time-capsule.md) — schema and auth model

