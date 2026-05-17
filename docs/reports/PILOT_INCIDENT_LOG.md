# Pilot Incident Log

## Pilot Metadata

- Initialized: `2026-05-17`
- Current release decision: `Go for QA pilot handoff`
- Signed artifact: `7039209964 / auraforge-3-signed-qa`
- Support owner: `AuraForge PM`
- Engineering owner: `AuraForge Eng`
- Triage cadence: daily during pilot, immediate escalation for `P0`/`P1`
- Escalation channel: `#auraforge-release-war-room` or project equivalent

## Incident Records

| Incident ID | Date/Time | Severity | Surface | Summary                               | Owner | ETA   | Status        | Resolution |
| ----------- | --------- | -------- | ------- | ------------------------------------- | ----- | ----- | ------------- | ---------- |
| `PILOT-000` | `TBD`     | `TBD`    | `TBD`   | No live pilot incidents recorded yet. | `TBD` | `TBD` | `Not started` | `TBD`      |

## Intake Fields

Use these fields for every live pilot issue before assigning severity:

1. Reporter and participant identifier.
2. macOS version.
3. Artifact installed.
4. Step affected: install, launch, session creation, generation, export, or other.
5. Exact error text or screenshot.
6. Reproduction steps.
7. Retry result.
8. Owner and next update time.

## Severity Reference

| Severity | Definition                                         | Action                                  |
| -------- | -------------------------------------------------- | --------------------------------------- |
| P0       | Data loss, security compromise, or full outage     | Immediate hold + escalation             |
| P1       | Critical workflow blocked for multiple pilot users | Block release/expansion until mitigated |
| P2       | Major defect with workaround                       | Continue with tracked fix               |
| P3       | Minor issue                                        | Backlog candidate                       |
