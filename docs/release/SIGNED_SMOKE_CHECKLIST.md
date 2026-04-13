# Signed Artifact Smoke Checklist

Use this checklist only on the signed artifact produced by `.github/workflows/release-rc.yml` in signed mode.

## Preconditions

1. Signed workflow run completed with `require_signed=true`.
2. Artifact metadata recorded (run URL, artifact name, SHA256).
3. Test machine is clean and not running previous AuraForge build.

## Deterministic Critical Path

| Step | Action                                   | Expected Result                                        | Pass/Fail | Notes |
| ---- | ---------------------------------------- | ------------------------------------------------------ | --------- | ----- |
| 1    | Install signed `.app` or `.dmg` artifact | Installation succeeds without trust bypass workarounds |           |       |
| 2    | Launch AuraForge                         | App opens without crash                                |           |       |
| 3    | Create a new session                     | Session appears in session list                        |           |       |
| 4    | Submit conversation input                | Message accepted and displayed                         |           |       |
| 5    | Trigger document generation              | Generated output appears in UI                         |           |       |
| 6    | Export/save generated output             | File is saved and readable from disk                   |           |       |

## Failure Classification

- Any failure in steps 1-6 is `P1` for Week 3 go/no-go.
- `P1` blocks go decision until fixed and revalidated.

## Evidence to Attach

1. Run URL and artifact ID from CI.
2. Screenshot or terminal evidence for each failed step.
3. Final pass/fail summary copied into:
   - `docs/reports/RC_DECISION_RECORD.md`
   - `docs/reports/WEEK3_GO_NO_GO.md`
