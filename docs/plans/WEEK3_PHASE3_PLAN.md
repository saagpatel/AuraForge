# AuraForge Phase 3 Week 3 Plan (Pilot-Readiness Kickoff)

## Week 3 Goal

Move from internal RC readiness to pilot-ready release operations with a signed CI artifact, controlled validation, and clear go/no-go evidence.

## Entry Criteria (already met)

- Week 1 deterministic gates are green.
- Week 2 release hardening is implemented.
- Local release bundles are building from `npm run release:tauri`.

## Primary Deliverables

1. Signed CI RC artifact (or explicit blocker decision with owner/date).
2. Pilot release readiness report with pass/fail evidence.
3. Runbook updates for install, rollback, and issue triage.
4. Signed artifact smoke evidence captured via `docs/release/SIGNED_SMOKE_CHECKLIST.md`.

## Day-by-Day Plan

### Day 1: Signing closure

1. Ensure `.github/workflows/release-rc.yml` is available on default branch (`main`).
2. Provision `APPLE_*` secrets in CI.
3. Run `.github/workflows/release-rc.yml` with `require_signed=true`.
4. Capture artifact links and workflow summary in `docs/reports/RC_DECISION_RECORD.md`.

Exit criteria:

- Signed mode detected in CI summary.
- Signed RC artifact uploaded.

### Day 2: Release validation

1. Execute smoke validation on the signed artifact using `docs/release/SIGNED_SMOKE_CHECKLIST.md`.
2. Record outcomes and defects in `docs/reports/RC_DECISION_RECORD.md`.
3. Fix any P0/P1 release defects and re-run smoke checks.

Exit criteria:

- Signed artifact passes critical-path smoke checks.

### Day 3: Operational readiness

1. Finalize support runbook for known failure modes and recovery steps.
2. Add rollback instructions for RC regressions.
3. Confirm owner mapping for release, QA sign-off, and escalation.

Exit criteria:

- Runbook exists and has named owners.

### Day 4: Pilot gate rehearsal

1. Re-run deterministic verify contract and release workflow.
2. Confirm no new security advisories and no open waivers past expiry.
3. Draft pilot go/no-go memo with objective gate outcomes.

Exit criteria:

- All required gates are green in a single evidence pack.

### Day 5: Phase 3 week-close decision

1. Hold go/no-go review.
2. If go: publish pilot kickoff checklist and candidate schedule.
3. If no-go: publish blocker list with owner/date and next remediation slice.

Exit criteria:

- Decision recorded with next action owners and dates.

## Definition of Done for Week 3

- Signed CI RC artifact exists and is validated.
- Critical-path smoke checks pass on signed build.
- Release/support/rollback runbooks are complete with owners.
- Pilot go/no-go decision is documented.
