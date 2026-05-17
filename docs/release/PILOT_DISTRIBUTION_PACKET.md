# Pilot Distribution Packet

## Current Candidate

- Release decision: `Go for QA pilot handoff`
- Signed workflow run: `https://github.com/saagpatel/AuraForge/actions/runs/25980981366`
- Signed artifact: `7039209964 / auraforge-3-signed-qa`
- App SHA256: `9ea1387665b78a0ab09cf67922bfbeded5dabc3b08b9ce8672ffaaaf31b01b94`
- DMG SHA256: `9466250dc96877642c171f2812a29b80d9dfaf4b623d742aa3bcb41ee1f4bf98`
- Signing identity: `Developer ID Application: SAAGAR I PATEL (3TGZFKFNA4)`
- Notarization status: `stapled-app`

## Human Inputs Required Before Send

1. Final participant roster.
2. Pilot support channel.
3. Active support-hours window.
4. Artifact sharing method or link.

## Distribution Message Draft

Subject: AuraForge QA pilot build is ready

Hi pilot team,

The signed AuraForge QA pilot build is ready for install and first-pass testing.

Build details:

- Artifact: `auraforge-3-signed-qa`
- App SHA256: `9ea1387665b78a0ab09cf67922bfbeded5dabc3b08b9ce8672ffaaaf31b01b94`
- DMG SHA256: `9466250dc96877642c171f2812a29b80d9dfaf4b623d742aa3bcb41ee1f4bf98`
- Notarization: `stapled-app`

Install and smoke path:

1. Download the shared pilot artifact.
2. Open the DMG and install AuraForge.
3. Launch AuraForge.
4. Create a small planning session.
5. Generate the project documents.
6. Export the generated files.
7. Report install, launch, generation, or export issues in the pilot support channel.

Please include the following with any issue report:

- macOS version.
- Whether the app launched successfully.
- The step where the issue occurred.
- Screenshot or exact error text, if available.
- Whether retrying changed the outcome.

Support window:

- Channel: `TBD`
- Active hours: `TBD`
- First response target: `30 minutes` during active pilot hours

## Send Checklist

- [ ] Participant roster is final.
- [ ] Artifact link is available to all participants.
- [ ] Artifact checksum is included in the message.
- [ ] Support channel is named.
- [ ] Active support-hours window is named.
- [ ] Rollback runbook owner is available during launch.
- [ ] Incident log is ready for live entries.
