# Rollback Runbook (Week 3 Pilot RC)

## Ownership

- Release rollback owner: `AuraForge PM`
- Technical executor: `AuraForge Eng`
- Escalation channel: `#auraforge-release-war-room` (or equivalent)

## Rollback Triggers

1. Any `P0` incident.
2. Any unresolved `P1` incident beyond same-day mitigation target.
3. Signed artifact verification failure (`codesign`, `spctl`, notarization/staple).
4. Security issue with high severity and no approved time-boxed waiver.

## Rollback Decision Steps

1. Confirm trigger condition and severity classification.
2. Freeze further pilot rollout actions.
3. PM records rollback decision timestamp and reason.
4. Engineering executes rollback path and confirms prior known-good artifact.

## Rollback Procedure

1. Identify last known-good release artifact and metadata.
2. Remove or de-prioritize failing candidate artifact from pilot distribution.
3. Re-publish known-good artifact link and checksum to pilot stakeholders.
4. Update decision records:
   - `docs/reports/RC_DECISION_RECORD.md`
   - `docs/reports/WEEK3_GO_NO_GO.md`
5. Open remediation issue with owner and target date.

## Post-Rollback Verification

1. Run engineering gate:
   - `bash .codex/scripts/run_verify_commands.sh`
2. Run security gate:
   - `npm audit --json`
3. Reconfirm release blocker status in:
   - `docs/release/RELEASE_BLOCKERS.md`
4. Validate critical path on known-good artifact:
   - startup -> session create -> input -> generate -> export

## Communication Template

1. What happened (one sentence).
2. Why rollback was required.
3. Current user impact.
4. Expected next update time.
5. Owner and remediation timeline.

## Exit Criteria from Rollback State

1. Root cause is documented.
2. Fix is implemented and validated.
3. Signed RC gates pass on new candidate.
4. PM approves transition from rollback state to re-evaluation.
