# AGENTS.md

<!-- comm-contract:start -->

## Communication Contract

- Inherit global Codex communication and reporting rules from `/Users/d/.codex/AGENTS.override.md` and `/Users/d/.codex/policies/communication/BigPictureReportingV1.md`.
- Repo-specific instructions below add project constraints only; do not restate global voice or status-reporting rules here.
<!-- comm-contract:end -->

## Inherited Operating Rules

- Inherit global git, review/fix, testing, docs, UI, security, skill-use, and reporting gates from `/Users/d/.codex/AGENTS.md` and active session instructions.
- Use `.codex/verify.commands` and `.codex/scripts/run_verify_commands.sh` as this repo-local verification authority when present.
- Add repo-specific constraints here only when this project has instructions that differ from global Codex defaults.

## Codex App Usage

- Use Codex App Projects for repo-specific implementation, review, and verification in this checkout.
- Use a Worktree when changing release flow, Tauri/Rust boundaries, performance gates, or multiple docs/code surfaces at once.
- Use the in-app browser or Playwright for UI workflows, responsive behavior, accessibility, and visual checks.
- Use computer use only for GUI-only desktop behavior that cannot be verified through tests, browser tooling, MCP, or CLI commands.
- Use artifacts for screenshots, release packets, PR notes, performance summaries, and handoff docs.
- Keep connectors read-first and task-scoped. Do not pull external context unless it directly supports the current repo task.
- Keep `.codex/verify.commands` as the verification authority; Codex App tools add evidence but do not replace the repo gate.
