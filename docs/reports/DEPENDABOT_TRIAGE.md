# Dependabot Triage

## Snapshot

- Reviewed: `2026-05-17`
- Base branch: `main`
- Current release state: `Go for QA pilot handoff`
- Current dependency PR state: `No open Dependabot PRs`

## Dependency PR Closeout

| PR    | Lane                                   | Outcome                                                                                                                                                   |
| ----- | -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `#7`  | `actions/setup-node` to `6.3.0`        | Merged directly after current checks were green.                                                                                                          |
| `#6`  | `actions/upload-artifact` to `7`       | Closed as superseded by `#23`, which applied the action pin update on current `main` and passed the full PR check set.                                    |
| `#8`  | `actions/github-script` to `8.0.0`     | Closed as superseded by `#23`, which applied the action pin update on current `main` and passed the full PR check set.                                    |
| `#9`  | `tj-actions/changed-files` to `47.0.5` | Closed as superseded by `#23`, which applied the action pin update on current `main` and passed the full PR check set.                                    |
| `#10` | `actions/checkout` to `6.0.2`          | Closed as superseded by `#23` after it conflicted with the earlier setup-node merge; the current-main action rollup passed the full PR check set.         |
| `#14` | npm/yarn dependency group              | Closed as stale/superseded because `main` already contains `picomatch` `4.0.4`, nested `picomatch` `2.3.2`, and `rollup` `4.60.4` in `package-lock.json`. |

## Verification

- `npm audit --json` reports `0` vulnerabilities.
- PR `#23` passed GitHub checks before merge.
- No open Dependabot PRs remain.

## Follow-Up

Resume dependency hygiene from new Dependabot PRs only. The April stale queue is closed.
