# AuraForge RC Checklist

## Current Status (2026-05-17)

- [x] Local verify + test + release gates are passing.
- [x] Hardened runtime is enabled.
- [x] Signed CI RC run completed with Apple signing and notarization credentials.
- [x] Signed critical-path smoke passed end-to-end.

## Build Inputs

- [x] Branch is up to date and release evidence is merged to `main`.
- [x] `.github/workflows/release-rc.yml` is merged to default branch (`main`) before dispatch.
- [x] `npm ci` succeeds on a clean checkout.
- [x] `bash .codex/scripts/run_verify_commands.sh` passes.

## Required Tests

- [x] `npm run test:web` passes.
- [x] `npm run test:smoke` passes.
- [x] `cargo test --manifest-path src-tauri/Cargo.toml` passes.

## Release Build

- [x] `npm run release:tauri` completes in signed CI.
- [x] RC artifacts exist under `src-tauri/target/release/bundle/`.
- [x] Workflow summary includes channel and signing mode.
- [x] Workflow summary includes signing identity, notarization status, and artifact SHA256 values.
- [x] For production-ready RC, run `.github/workflows/release-rc.yml` with `require_signed=true`.

## macOS Hardening and Signing

- [x] `hardenedRuntime` is enabled in `src-tauri/tauri.conf.json`.
- [x] Signing mode is `signed` when all Apple secrets are present.
- [x] `codesign --verify --deep --strict` passes for the `.app` bundle (CI verification step).
- [x] `spctl --assess --type execute` passes for the `.app` bundle (CI verification step).
- [x] `xcrun stapler validate` passes for app or dmg artifact in signed mode.
- [x] If signing mode is `unsigned`, release is marked internal QA only.

## Security and Risk

- [x] `npm audit --json` reviewed and triaged.
- [x] No unresolved vulnerabilities require waiver ownership in `docs/security/DEPENDENCY_WAIVERS.md`.
- [x] Secret scanning remains enabled in CI and local hooks.

## Go / No-Go

- [x] RC report is published with command evidence.
- [x] Remaining blockers are explicitly listed with owner and target date.

## Current QA Candidate Evidence (2026-05-17)

- Signed workflow run: `https://github.com/saagpatel/AuraForge/actions/runs/25980981366`
- Signed artifact: `7039209964 / auraforge-3-signed-qa`
- App SHA256: `9ea1387665b78a0ab09cf67922bfbeded5dabc3b08b9ce8672ffaaaf31b01b94`
- DMG SHA256: `9466250dc96877642c171f2812a29b80d9dfaf4b623d742aa3bcb41ee1f4bf98`
- Current recommendation: `Go for QA pilot handoff`
