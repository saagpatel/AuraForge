# Dependabot Triage

## Snapshot

- Reviewed: `2026-05-17`
- Base branch: `main`
- Current release state: `Go for QA pilot handoff`

## Open Dependency PRs

| PR    | Lane                                   | Current signal                                                                                        | Recommended action                                                                     |
| ----- | -------------------------------------- | ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `#6`  | `actions/upload-artifact` to `7`       | Latest rerun shows tests and secrets passing; older perf-foundation failures remain in check history. | Re-run after CI permission fix lands; merge only if current required checks are green. |
| `#7`  | `actions/setup-node` to `6.3.0`        | Tests and perf-foundation checks pass; Dependabot PR is action-only.                                  | Merge after CI permission fix lands and current checks stay green.                     |
| `#8`  | `actions/github-script` to `8.0.0`     | Action runtime update.                                                                                | Re-run after CI permission fix, then merge if green.                                   |
| `#9`  | `tj-actions/changed-files` to `47.0.5` | Action runtime update touching lockfile-rationale enforcement.                                        | Re-run after CI permission fix; verify lockfile enforcement still passes before merge. |
| `#10` | `actions/checkout` to `6.0.2`          | Action runtime update with current checks green.                                                      | Merge after CI permission fix lands and current checks stay green.                     |
| `#14` | npm/yarn dependency group              | `DIRTY`; lockfile-rationale enforcement failed because the PR needs a lockfile rationale body/update. | Rebase/update and add lockfile rationale before considering merge.                     |

## Triage Decision

Do not batch-merge these before the CI hygiene fix lands. The safest order is:

1. Land CI permission fix.
2. Re-run action-only Dependabot PR checks.
3. Merge action-only PRs one at a time when green.
4. Rebase and repair `#14` separately because it has a content/rationale issue, not just stale check noise.
