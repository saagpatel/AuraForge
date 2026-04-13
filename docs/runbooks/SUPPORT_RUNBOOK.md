# Support Runbook (Week 3 Pilot RC)

## Ownership

- Primary owner: `AuraForge PM`
- Technical owner: `AuraForge Eng`
- Escalation channel: `#auraforge-release-war-room` (or equivalent)
- Decision authority for release hold: `AuraForge PM`

## Service Level Targets (Pilot Phase)

- First response target: `30 minutes` during active pilot hours
- Triage classification target: `60 minutes`
- P1 mitigation target: `same business day`
- P2 mitigation target: `next business day`

## Severity Definitions

| Severity | Definition                                                          | Pilot Release Impact         |
| -------- | ------------------------------------------------------------------- | ---------------------------- |
| P0       | Data loss, security compromise, or app unusable for all pilot users | Immediate release hold       |
| P1       | Critical workflow blocked for multiple pilot users                  | Release hold until mitigated |
| P2       | Major defect with workaround                                        | Continue with tracked fix    |
| P3       | Minor defect or UX issue                                            | Backlog candidate            |

## Triage Decision Tree

1. Confirm report scope: single user or multiple users.
2. Confirm blast radius: startup, generation, export, or release install path.
3. Classify severity (`P0`/`P1`/`P2`/`P3`) using table above.
4. If `P0` or `P1`, immediately trigger release hold and open escalation thread.
5. Assign owner and ETA, then publish status update every 60 minutes until mitigated.

## Top Failure Modes and Actions

| Failure Mode             | Detection Signal                             | Immediate Action                                         | Escalation         |
| ------------------------ | -------------------------------------------- | -------------------------------------------------------- | ------------------ |
| App fails to launch      | Crash on open, Gatekeeper block, launch logs | Capture crash/log output and verify app signature state  | AuraForge Eng      |
| Session creation fails   | UI cannot create conversation session        | Collect reproduction steps and backend logs              | AuraForge Eng      |
| Generation request fails | No output or error on generate action        | Capture request/response logs and retry once             | AuraForge Eng      |
| Export/save fails        | File not created or write error              | Validate output path permissions and app sandbox path    | AuraForge Eng      |
| Signed artifact rejected | Notarization/Gatekeeper failure              | Halt pilot release and run release verification workflow | AuraForge PM + Eng |

## Communication Cadence

1. Initial incident post within 15 minutes of classification.
2. Status updates every 60 minutes for `P0`/`P1`.
3. Resolution post with root cause and mitigation once closed.

## Closure Criteria

1. Incident is reproducible and root cause identified.
2. Mitigation is deployed and validated.
3. Follow-up issue is filed for any non-permanent fix.
