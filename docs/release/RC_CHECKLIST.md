# AuraForge RC Checklist

## Current Status (2026-02-22)

- [x] Local verify + test + release gates are passing.
- [x] Hardened runtime is enabled.
- [ ] Signed CI RC run is pending Apple secret provisioning.

## Build Inputs

- [ ] Branch is up to date and CI is green.
- [ ] `.github/workflows/release-rc.yml` is merged to default branch (`main`) before dispatch.
- [ ] `npm ci` succeeds on a clean checkout.
- [ ] `bash .codex/scripts/run_verify_commands.sh` passes.

## Required Tests

- [ ] `npm run test:web` passes.
- [ ] `npm run test:smoke` passes.
- [ ] `cargo test --manifest-path src-tauri/Cargo.toml` passes.

## Release Build

- [ ] `npm run release:tauri` completes.
- [ ] RC artifacts exist under `src-tauri/target/release/bundle/`.
- [ ] Workflow summary includes channel and signing mode.
- [ ] Workflow summary includes signing identity, notarization status, and artifact SHA256 values.
- [ ] For production-ready RC, run `.github/workflows/release-rc.yml` with `require_signed=true`.

## macOS Hardening and Signing

- [ ] `hardenedRuntime` is enabled in `src-tauri/tauri.conf.json`.
- [ ] Signing mode is `signed` when all Apple secrets are present.
- [ ] `codesign --verify --deep --strict` passes for the `.app` bundle (CI verification step).
- [ ] `spctl --assess --type execute` passes for the `.app` bundle (CI verification step).
- [ ] `xcrun stapler validate` passes for app or dmg artifact in signed mode.
- [ ] If signing mode is `unsigned`, release is marked internal QA only.

## Security and Risk

- [ ] `npm audit --json` reviewed and triaged.
- [ ] Any unresolved vulnerability has waiver owner and expiry in `docs/security/DEPENDENCY_WAIVERS.md`.
- [ ] Secret scanning remains enabled in CI and local hooks.

## Go / No-Go

- [ ] RC report is published with command evidence.
- [ ] Remaining blockers are explicitly listed with owner and target date.
