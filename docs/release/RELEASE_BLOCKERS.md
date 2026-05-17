# Release Blockers

## Open Blockers

None.

## Resolved Today (2026-05-17)

| Item                                              | Evidence                                                                                                                                                                                                                | Status |
| ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| Signed critical-path smoke passed                 | Signed app installed, launched, created a session, generated 10 documents, and exported 12 files to `/Users/d/Projects/auraforge-signed-smoke-export/i-want-to-build-a-small-desktop-tool-called-smokenotes-for-c-plan` | Closed |
| Signing and notarization repository secrets added | `npm run phase4:prereqs` reports required signing secrets and notarization credentials present for `saagpatel/AuraForge`                                                                                                | Closed |
| App Store Connect API-key notarization supported  | `release-rc.yml` accepts `APPLE_API_KEY_ID`, `APPLE_API_ISSUER`, and `APPLE_API_PRIVATE_KEY` as the notarization set                                                                                                    | Closed |
| Signed release lane validated                     | Run `25980981366` produced signed QA artifact `auraforge-3-signed-qa`; codesign, Gatekeeper, notarization, and stapler passed                                                                                           | Closed |

## Resolved Today (2026-02-22)

| Item                                     | Evidence                                                                                                         | Status                     |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | -------------------------- |
| PR `#12` merged to `main`                | `gh pr view 12 -R saagar210/auraforge --json state,mergedAt,mergeCommit`                                         | Closed                     |
| `release-rc` published on default branch | `gh workflow list -R saagar210/auraforge --json name,path,state` shows `.github/workflows/release-rc.yml` active | Closed                     |
| Unsigned control release path validated  | Run `22276565971` succeeded; artifact `auraforge-5-unsigned-qa` ID `5606803423`                                  | Closed                     |
| Signed gate re-test executed             | Run `22276721898` fails fast with explicit missing-secrets enforcement                                           | Closed (evidence captured) |

## Week 4 Outcome

- Week 4 originally closed as: `No-go`
- Current release-blocker state: `Closed`
- Follow-on path: `QA pilot readiness / release handoff`

## Exit Criteria for Blocker Closure

- [x] PR `#12` merged to `main`.
- [x] `release-rc` appears in default-branch workflow list.
- [x] Required signing secrets and one notarization credential set are present.
- [x] Signed CI RC artifact produced and verifiably signed/notarized.
- [x] Signed smoke checklist passes critical path end-to-end.

## Note

- `main` branch protection remains disabled by repository-owner direction for this closure sequence.
