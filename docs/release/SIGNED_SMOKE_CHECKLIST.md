# Signed Artifact Smoke Checklist

Use this checklist only on the signed artifact produced by `.github/workflows/release-rc.yml` in signed mode.

## Preconditions

1. Signed workflow run completed with `require_signed=true`.
2. Artifact metadata recorded (run URL, artifact name, SHA256).
3. Test machine is clean and not running previous AuraForge build.

## Deterministic Critical Path

| Step | Action                                   | Expected Result                                        | Pass/Fail | Notes                                                                                                                                                         |
| ---- | ---------------------------------------- | ------------------------------------------------------ | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | Install signed `.app` or `.dmg` artifact | Installation succeeds without trust bypass workarounds | Pass      | `hdiutil verify`, `codesign --verify --deep --strict`, and `spctl --assess --type execute` passed for artifact `7039209964 / auraforge-3-signed-qa`.          |
| 2    | Launch AuraForge                         | App opens without crash                                | Pass      | Installed signed app launched from `/tmp/AuraForge-signed-smoke-install/AuraForge.app`.                                                                       |
| 3    | Create a new session                     | Session appears in session list                        | Pass      | Smoke project session appeared in the sidebar as `I want to build a small ...`.                                                                               |
| 4    | Submit conversation input                | Message accepted and displayed                         | Pass      | Three user prompts and three assistant responses persisted to `~/.auraforge/auraforge.db`.                                                                    |
| 5    | Trigger document generation              | Generated output appears in UI                         | Pass      | Documents tab appeared with generated `START_HERE.md`, `README.md`, `SPEC.md`, `CLAUDE.md`, `PROMPTS.md`, `MODEL_HANDOFF.md`, `CONVERSATION.md`, and reports. |
| 6    | Export/save generated output             | File is saved and readable from disk                   | Pass      | Export saved to `/Users/d/Projects/auraforge-signed-smoke-export/i-want-to-build-a-small-desktop-tool-called-smokenotes-for-c-plan`.                          |

## Failure Classification

- Any failure in steps 1-6 is `P1` for Week 3 go/no-go.
- `P1` blocks go decision until fixed and revalidated.

## Evidence to Attach

1. Run URL and artifact ID from CI.
2. Screenshot or terminal evidence for each failed step.
3. Final pass/fail summary copied into:
   - `docs/reports/RC_DECISION_RECORD.md`
   - `docs/reports/WEEK3_GO_NO_GO.md`

## Final Pass Summary (2026-05-17)

- Signed workflow run: `https://github.com/saagpatel/AuraForge/actions/runs/25980981366`
- Artifact: `7039209964 / auraforge-3-signed-qa`
- App SHA256: `9ea1387665b78a0ab09cf67922bfbeded5dabc3b08b9ce8672ffaaaf31b01b94`
- DMG SHA256: `9466250dc96877642c171f2812a29b80d9dfaf4b623d742aa3bcb41ee1f4bf98`
- Local smoke model: `qwen2.5-coder:1.5b` via Ollama at `http://localhost:11434`
- Generated document count: `10` persisted documents; `12` exported files including structured manifest/checklist layout.
- Export folder: `/Users/d/Projects/auraforge-signed-smoke-export/i-want-to-build-a-small-desktop-tool-called-smokenotes-for-c-plan`
