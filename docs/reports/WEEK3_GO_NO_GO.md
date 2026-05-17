# Week 3 Go / No-Go Packet

## Decision Snapshot

- Week: `Week 3 (Phase 3)`
- Decision status: `Go`
- Decision date: `2026-05-17`
- PM owner: `AuraForge PM`
- Engineering owner: `AuraForge Eng`

## Release Candidate Context

- Candidate label: `RC1-week3-gate`
- Target channel: `qa`
- Workflow: `.github/workflows/release-rc.yml`
- Required mode: `require_signed=true`

## Gate Scorecard

| Gate                             | Command / Workflow                                 | Source                                     | Status | Owner         | Notes                                                                                           |
| -------------------------------- | -------------------------------------------------- | ------------------------------------------ | ------ | ------------- | ----------------------------------------------------------------------------------------------- |
| Engineering baseline             | `bash .codex/scripts/run_verify_commands.sh`       | `.codex/verify.commands`                   | Pass   | AuraForge Eng | Deterministic gate green locally                                                                |
| Security                         | `npm audit --json`                                 | `docs/release/RC_CHECKLIST.md`             | Pass   | AuraForge Eng | 0 vulnerabilities                                                                               |
| Signed CI artifact               | `release-rc` (`channel=qa`, `require_signed=true`) | `.github/workflows/release-rc.yml`         | Pass   | AuraForge PM  | Run `25980981366` produced signed QA artifact `7039209964 / auraforge-3-signed-qa`              |
| Signature verification           | `codesign` checks in workflow                      | `scripts/release/verify-macos-artifact.sh` | Pass   | AuraForge Eng | Workflow verification passed; local signed app verification also passed                         |
| Gatekeeper verification          | `spctl --assess` in workflow                       | `scripts/release/verify-macos-artifact.sh` | Pass   | AuraForge Eng | Local smoke install passed `spctl --assess --type execute` with `source=Notarized Developer ID` |
| Notarization/staple verification | `xcrun stapler validate` in workflow               | `scripts/release/verify-macos-artifact.sh` | Pass   | AuraForge Eng | Latest signed run reports notarization status `stapled-app`                                     |
| Signed critical-path smoke       | Install + launch + session + generate + export     | `docs/release/SIGNED_SMOKE_CHECKLIST.md`   | Pass   | AuraForge Eng | Signed app generated 10 documents and exported 12 readable files                                |

## Evidence Register

| Evidence Item        | Value                                                              |
| -------------------- | ------------------------------------------------------------------ |
| Workflow run URL     | `https://github.com/saagpatel/AuraForge/actions/runs/25980981366`  |
| Workflow run ID      | `25980981366`                                                      |
| Uploaded artifact ID | `7039209964 / auraforge-3-signed-qa`                               |
| App path             | `src-tauri/target/release/bundle/macos/AuraForge.app`              |
| DMG path             | `src-tauri/target/release/bundle/dmg/AuraForge_0.1.0_aarch64.dmg`  |
| App SHA256           | `9ea1387665b78a0ab09cf67922bfbeded5dabc3b08b9ce8672ffaaaf31b01b94` |
| DMG SHA256           | `9466250dc96877642c171f2812a29b80d9dfaf4b623d742aa3bcb41ee1f4bf98` |
| Signing identity     | `Developer ID Application: SAAGAR I PATEL (3TGZFKFNA4)`            |
| Notarization status  | `stapled-app`                                                      |

## Signed Smoke Evidence (2026-05-17)

| Evidence Item  | Value                                                                                                                                       |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Installed app  | `/tmp/AuraForge-signed-smoke-install/AuraForge.app`                                                                                         |
| Smoke project  | `SmokeNotes` desktop notes planner                                                                                                          |
| Local model    | `qwen2.5-coder:1.5b` via Ollama                                                                                                             |
| Generated docs | 10 persisted documents in `~/.auraforge/auraforge.db`                                                                                       |
| Exported files | 12 readable files under `/Users/d/Projects/auraforge-signed-smoke-export/i-want-to-build-a-small-desktop-tool-called-smokenotes-for-c-plan` |
| Result         | Pass                                                                                                                                        |

## Command Evidence (2026-02-22)

| Command                                                                                      | Result | Notes                                                    |
| -------------------------------------------------------------------------------------------- | ------ | -------------------------------------------------------- |
| `gh workflow run release-rc.yml -R saagar210/auraforge -f channel=qa -f require_signed=true` | Fail   | `HTTP 404: workflow ... not found on the default branch` |
| `gh secret list -R saagar210/auraforge`                                                      | Fail   | No repository secrets configured                         |
| `bash .codex/scripts/run_verify_commands.sh`                                                 | Pass   | Deterministic local gates green                          |
| `npm audit --json`                                                                           | Pass   | 0 vulnerabilities                                        |

## Command Evidence (2026-05-17)

| Command / Check                                                                                         | Result | Notes                                                           |
| ------------------------------------------------------------------------------------------------------- | ------ | --------------------------------------------------------------- |
| `gh workflow run release-rc.yml -R saagpatel/AuraForge --ref main -f channel=qa -f require_signed=true` | Pass   | Run `25980981366` succeeded                                     |
| `hdiutil verify /tmp/auraforge-signed-smoke.O5QSII/dmg/AuraForge_0.1.0_aarch64.dmg`                     | Pass   | DMG checksum valid                                              |
| `codesign --verify --deep --strict --verbose=2 /tmp/AuraForge-signed-smoke-install/AuraForge.app`       | Pass   | Installed app valid on disk                                     |
| `spctl --assess --type execute --verbose=4 /tmp/AuraForge-signed-smoke-install/AuraForge.app`           | Pass   | Accepted as Notarized Developer ID                              |
| Signed app UI smoke                                                                                     | Pass   | Launch, session, conversation, generation, and export completed |

## Open Risks and Mitigations

None open for QA pilot handoff. Prior signed workflow, credential, notarization, and critical-path smoke risks are now closed.

## Recommendation

- Recommendation: `Go` for QA pilot handoff.

## Required Actions Before Re-evaluation

None. Required release gates now have pass evidence.
