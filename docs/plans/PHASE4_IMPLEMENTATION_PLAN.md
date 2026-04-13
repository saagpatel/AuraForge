# AuraForge Phase Four Implementation Plan (Weeks 4-5)

## Summary

Phase Four is a two-week execution phase to move AuraForge from Week 3 no-go into one of two controlled outcomes:

1. Pilot Go with bounded rollout and incident controls.
2. No-go with closed blocker remediation and explicit re-decision evidence.

This phase uses strict release gating:

1. No open P1 at decision points.
2. No unwaived high/critical security risk.
3. No required gate in `fail` or `not-run` state.

## Baseline at Phase Start

1. Local verify gates are passing.
2. Week 3 go/no-go is `No-go`.
3. External blockers remain in release signing and workflow availability.

Sources:

1. `docs/reports/WEEK3_GO_NO_GO.md`
2. `docs/reports/RC_DECISION_RECORD.md`
3. `docs/release/RELEASE_BLOCKERS.md`

## Success Criteria

1. Signed CI RC artifact is produced and validated with explicit evidence.
2. Signed critical path smoke succeeds end-to-end.
3. Support and rollback procedures are exercised and documented.
4. End-of-phase decision is explicit and commits Week 6 scope.

## Workstreams

1. Release gate closure.
2. Signed artifact validation.
3. Pilot operations and incident control.
4. Governance and decision evidence.

## Week 4 Plan

### Day 1 (Infrastructure/Access)

1. Ensure release workflow is available on default branch.
2. Validate all `APPLE_*` secrets are configured.
3. Update blockers with owner/date/status.

Deliverables:

1. Workflow visibility confirmed.
2. Secret readiness confirmed or explicitly blocked.

### Day 2 (Signed Build Execution)

1. Trigger signed release workflow (`require_signed=true`).
2. Capture run URL, run ID, artifact ID, checksums, signing identity, notarization status.
3. Retry up to 3 times for transient failures.

Deliverables:

1. Signed artifact record or failure evidence with root-cause notes.

### Day 3 (Signed Smoke + Triage)

1. Execute signed smoke checklist.
2. Capture step-level pass/fail and evidence.
3. Fix/retest any P1 blockers.

Deliverables:

1. Completed smoke checklist and defect status.

### Day 4 (Gate Rehearsal)

1. Re-run deterministic verify and security audit.
2. Confirm signed release evidence remains valid.
3. Finalize packet for weekly decision.

Deliverables:

1. Review-ready go/no-go packet with gate scorecard.

### Day 5 (Week 4 Decision)

1. Record Week 4 decision:
   - Go to Week 5 Track A (pilot operation), or
   - No-go to Week 5 Track B (remediation sprint).
2. Assign owners and next-week commitments.

## Week 5 Plan

### Track A (if Week 4 = Go)

Day 1:

1. Kick off pilot with known-good artifact and checksums.
2. Activate support coverage.

Day 2:

1. Run active triage windows and incident tracking.
2. Freeze expansion on unresolved P1.

Day 3:

1. Apply stabilization fixes.
2. Re-run verify/security/signed smoke checks.

Day 4:

1. Review reliability trend and support load.
2. Confirm rollback readiness.

Day 5:

1. Decide pilot expansion (`+2x` cohort default) or hold.
2. Publish Phase Four closeout and Week 6 objective.

### Track B (if Week 4 = No-go)

Day 1:

1. Re-prioritize blockers with owner and ETA.

Day 2:

1. Resolve signing lane blockers and rerun signed workflow.

Day 3:

1. Re-run signed smoke; fix/retest failures.

Day 4:

1. Replay full gates and confirm evidence completeness.

Day 5:

1. Re-decide Go/No-go.
2. Publish Week 6 pilot-start or remediation-only scope.

## Canonical Verification Matrix

1. Phase Four gate pack:
   - Command: `bash scripts/release/run-phase4-gates.sh saagar210/auraforge`
   - Source: `scripts/release/run-phase4-gates.sh`
2. Engineering gate:
   - Command: `bash .codex/scripts/run_verify_commands.sh`
   - Source: `.codex/verify.commands`
3. Security gate:
   - Command: `npm audit --json`
   - Source: `docs/release/RC_CHECKLIST.md`
4. Signed release gate:
   - Workflow: `.github/workflows/release-rc.yml` with `require_signed=true`
   - Source: `docs/release/RC_CHECKLIST.md`
5. Signed smoke gate:
   - Source: `docs/release/SIGNED_SMOKE_CHECKLIST.md`

## Reporting Artifacts

1. `docs/reports/PHASE4_PREREQ_CHECK.md`
2. `docs/reports/WEEK4_GO_NO_GO.md`
3. `docs/reports/WEEK5_PHASE4_CLOSEOUT.md`
4. `docs/reports/PILOT_INCIDENT_LOG.md`

## Definition of Done

1. Signed release evidence is complete and auditable.
2. Critical-path signed smoke is passing.
3. Incident and rollback operations were exercised.
4. Phase Four closeout decision and Week 6 scope are documented.
