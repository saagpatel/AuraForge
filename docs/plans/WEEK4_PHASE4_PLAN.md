# AuraForge Week 4 Plan (Phase 4): Pilot Start and Stability Control

## Week 4 Objective

Transition from signed RC decision to controlled pilot execution with strict incident handling, daily gate evidence, and a production-readiness recommendation.

Canonical phase plan: `docs/plans/PHASE4_IMPLEMENTATION_PLAN.md`

## Week 4 Entry Gate

Week 4 starts on one of two tracks based on Week 3 outcome:

1. **Track A (Go path)**: Signed RC gates passed and go/no-go is `Go`.
2. **Track B (No-go path)**: Signed RC gates not fully passed; unresolved blockers remain.

## Track A: Go Path (Pilot Start)

### Day 1: Pilot activation

1. Publish pilot kickoff checklist and participant roster.
2. Distribute validated signed artifact and checksum values.
3. Confirm support and rollback war-room cadence.

Exit criteria:

1. Pilot participants have install instructions and known-good artifact.
2. Owners and escalation path are acknowledged.

### Day 2: First pilot telemetry and triage

1. Run pilot with active support window.
2. Triage all incoming issues using severity model from `docs/runbooks/SUPPORT_RUNBOOK.md`.
3. Block rollout expansion on any `P0`/`P1`.

Exit criteria:

1. No unresolved `P0`/`P1` at day close.

### Day 3: Stabilization patch window

1. Implement and verify fixes for pilot-blocking defects.
2. Re-run deterministic quality gates and signed critical-path smoke.
3. Update pilot change log and known issues.

Exit criteria:

1. Fixes are validated and regression risk is controlled.

### Day 4: Reliability confidence pass

1. Re-run release and security gates.
2. Validate onboarding/install success rate from pilot feedback.
3. Confirm rollback readiness remains current.

Exit criteria:

1. Gate evidence remains green after patches.
2. Pilot support load is within planned capacity.

### Day 5: Week 4 closeout decision

1. Publish Week 4 pilot summary and recommendation.
2. Decide whether to expand pilot scope in Week 5.
3. Record residual risks with owner/date.

Exit criteria:

1. Decision and next scope are documented.

## Track B: No-go Path (Remediation Sprint)

### Day 1: Blocker burn-down planning

1. Freeze pilot launch actions.
2. Prioritize unresolved blockers from `docs/release/RELEASE_BLOCKERS.md`.
3. Assign owner + ETA per blocker.
4. Run `scripts/release/check-phase4-prereqs.sh` and archive output in `docs/reports/PHASE4_PREREQ_CHECK.md`.

### Day 2: Signing/CI closure

1. Ensure release workflow exists on `main`.
2. Configure `APPLE_*` secrets.
3. Re-run signed workflow and collect evidence.

### Day 3: Signed smoke closure

1. Execute `docs/release/SIGNED_SMOKE_CHECKLIST.md`.
2. Fix and retest any `P1` failures.
3. Update `RC_DECISION_RECORD.md` and `WEEK3_GO_NO_GO.md`.

### Day 4: Rehearsal rerun

1. Re-run full verify and security gates.
2. Validate signed artifact verification outputs are captured.
3. Hold interim decision review.

### Day 5: Re-decision

1. Final go/no-go re-evaluation.
2. If `Go`, re-baseline Week 5 as pilot start.
3. If `No-go`, create Week 5 remediation scope only.

## Required Week 4 Gates

1. `bash .codex/scripts/run_verify_commands.sh` passes.
2. `npm audit --json` remains at no unwaived high/critical risk.
3. Signed release workflow evidence includes:
   - signing mode
   - signing identity
   - notarization/staple status
   - artifact SHA256
4. Critical-path smoke outcome is recorded from signed artifact.

## Deliverables by End of Week 4

1. Week 4 status report (`Go path` pilot summary or `No-go path` remediation closure).
2. Updated release blockers and decision records.
3. Week 5 objective and committed scope.
4. Updated `docs/reports/WEEK4_GO_NO_GO.md`.
