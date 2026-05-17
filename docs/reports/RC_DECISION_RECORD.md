# RC Decision Record

## Decision Metadata

- Decision status: `No-go`
- Decision date: `2026-02-22`
- Decision timestamp (UTC): `2026-02-22T12:01:17Z`
- Decision owners: `AuraForge PM` (primary), `AuraForge Eng` (backup)
- Candidate label: `RC1-phase4-week4-close`
- Target channel: `qa`
- Follow-on track: `Week 5 Track B (remediation sprint)`

## Required Evidence Fields

- Latest signed workflow run URL: `https://github.com/saagpatel/AuraForge/actions/runs/25980981366`
- Latest signed workflow run ID: `25980981366`
- Latest signed workflow result: `success`
- Prior signed workflow run URL: `https://github.com/saagar210/auraforge/actions/runs/22276565984`
- Signed artifact ID/name: `7039209964 / auraforge-3-signed-qa`
- Signed artifact app path: `src-tauri/target/release/bundle/macos/AuraForge.app`
- Signed artifact dmg path: `src-tauri/target/release/bundle/dmg/AuraForge_0.1.0_aarch64.dmg`
- Signed artifact app SHA256: `9ea1387665b78a0ab09cf67922bfbeded5dabc3b08b9ce8672ffaaaf31b01b94`
- Signed artifact dmg SHA256: `9466250dc96877642c171f2812a29b80d9dfaf4b623d742aa3bcb41ee1f4bf98`
- Signing identity: `Developer ID Application: SAAGAR I PATEL (3TGZFKFNA4)`
- Notarization status: `stapled-app`
- Unsigned control run URL: `https://github.com/saagar210/auraforge/actions/runs/22276565971`
- Unsigned artifact ID/name: `5606803423 / auraforge-5-unsigned-qa`
- Unsigned artifact digest: `sha256:169ebd16b7dcca951c1776600859f0018b76ea68a78e4c6ec5286dfe0de89e21`

## Gate Results (Pass/Fail Contract)

| Gate                                                                | Source                                                                         | Status  | Evidence                                                                    |
| ------------------------------------------------------------------- | ------------------------------------------------------------------------------ | ------- | --------------------------------------------------------------------------- |
| Engineering baseline (`run_verify_commands.sh`)                     | `.codex/verify.commands`                                                       | Pass    | Local run passed on 2026-02-22                                              |
| Web tests (`npm run test:web`)                                      | `package.json`                                                                 | Pass    | Included in verify run on 2026-02-22                                        |
| Smoke tests (`npm run test:smoke`)                                  | `package.json`                                                                 | Pass    | Deterministic local smoke lane passed on 2026-02-22                         |
| Rust tests (`cargo test --manifest-path src-tauri/Cargo.toml`)      | `package.json`                                                                 | Pass    | Included in verify run on 2026-02-22                                        |
| Security (`npm audit --json`)                                       | `docs/release/RC_CHECKLIST.md`                                                 | Pass    | 0 vulnerabilities on 2026-02-22                                             |
| Signed CI release (`release-rc` with `require_signed=true`)         | `.github/workflows/release-rc.yml`                                             | Pass    | Latest run `25980981366` produced signed QA artifact                        |
| Signed artifact verification (`codesign`/`spctl`/`stapler`)         | `.github/workflows/release-rc.yml`, `scripts/release/verify-macos-artifact.sh` | Pass    | Codesign, Gatekeeper, notarization, and stapler passed in run `25980981366` |
| Critical-path signed artifact smoke                                 | `docs/release/SIGNED_SMOKE_CHECKLIST.md`                                       | Not run | Signed artifact available; smoke not executed                               |
| Unsigned control release (`release-rc` with `require_signed=false`) | `.github/workflows/release-rc.yml`                                             | Pass    | Run `22276565971` produced unsigned QA artifact                             |

## Recommendation

- Current recommendation: `No-go until signed smoke completes`
- Rationale:

1. Signed CI now builds, signs, notarizes, verifies, and uploads the QA artifact successfully.
2. Critical-path signed artifact smoke has not been executed against the signed artifact.
3. Engineering and security baselines are stable, so remaining work is isolated to signed smoke closure.

## Open Blockers

1. Execute signed critical-path smoke checklist on the signed artifact.
2. Update this record to `Go` only if signed smoke passes.

## Execution Notes (2026-05-17)

1. Command: `xcrun notarytool history --key ~/.appstoreconnect/private_keys/AuthKey_6NPVH55ZWG.p8 --key-id 6NPVH55ZWG --issuer fd4f140d-508c-4f9d-9984-8e088cccc10a --output-format json`
   - Result: App Store Connect API key accepted by Apple.
2. Command: `gh workflow run release-rc.yml -R saagpatel/AuraForge --ref main -f channel=qa -f require_signed=true`
   - Result: run `25980981366` succeeded and uploaded artifact `7039209964 / auraforge-3-signed-qa`.
3. Command: `npm run phase4:gates`
   - Result: Phase 4 gate pack passed locally before the workflow fix was merged.

## Execution Notes (2026-02-22)

1. Command: `gh pr view 12 -R saagar210/auraforge --json state,mergedAt,mergeCommit`
   - Result: PR merged at `2026-02-22T11:41:01Z`; merge commit `09b4add63251e18d35d4c08cb8d21881339192cb`.
2. Command: `gh workflow list -R saagar210/auraforge --json name,path,state`
   - Result: `release-rc` workflow is active on default branch.
3. Command: `gh secret list -R saagar210/auraforge --json name,updatedAt`
   - Result: `[]` (required `APPLE_*` secrets missing).
4. Command: `gh workflow run release-rc.yml -R saagar210/auraforge --ref main -f channel=qa -f require_signed=true`
   - Result: latest run `22276721898` failed early with missing-secrets enforcement.
5. Command: `gh workflow run release-rc.yml -R saagar210/auraforge --ref main -f channel=qa -f require_signed=false`
   - Result: run `22276565971` succeeded; unsigned artifact uploaded.
6. Command: `bash .codex/scripts/run_verify_commands.sh`, `npm audit --json`, `npm run phase4:gates`
   - Result: engineering and security lanes pass; release prerequisite lane fails due missing secrets.
