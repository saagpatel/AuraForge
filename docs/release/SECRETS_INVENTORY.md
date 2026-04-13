# AuraForge Release Secrets Inventory

This inventory is used by `.github/workflows/release-rc.yml`.

## Required for Signed/Notarized macOS RC

- `APPLE_CERTIFICATE`:
  Base64-encoded `.p12` signing certificate.
- `APPLE_CERTIFICATE_PASSWORD`:
  Password for the signing certificate.
- `APPLE_SIGNING_IDENTITY`:
  macOS signing identity string.
- `APPLE_ID`:
  Apple ID used for notarization.
- `APPLE_PASSWORD`:
  App-specific password for notarization.
- `APPLE_TEAM_ID`:
  Apple Developer Team ID.

## Behavior

- If all values are present, release workflow reports `signing mode: signed`.
- If any value is missing, release workflow reports `signing mode: unsigned`.
- Unsigned artifacts are internal QA only and do not satisfy production-ready release criteria.

## Ownership

- Release owner: `AuraForge PM`
- Backup owner: `AuraForge Eng`
- Last reviewed: `2026-02-22`
