# Contributing

Thank you for your interest in contributing!

## Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Make your changes
4. Commit using [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `chore:`, etc.
5. Push and open a pull request

## Reporting Issues

Open a [GitHub Issue](../../issues) with a clear description and steps to reproduce.

## Code Style

Follow the existing conventions in the codebase.

## Verification

Run from the repository root. CI uses Node 20 and the committed npm lockfile:

```bash
npm ci
# Focused startup/session/chat/forge/save scenario using mocked Tauri calls
npm run test:smoke
# Focus another web test by its file path
npm run test:web -- src/test/smoke/workflow.smoke.test.ts
# Broader web tests, then TypeScript and Vite production build
npm run test:web
npm run build
```

Installation needs registry access and runs the Husky `prepare` script; use an
isolated checkout if other worktrees share Git configuration. Web tests use
[`src/test/setup.ts`](src/test/setup.ts) to mock the native boundary. They do not
need Ollama, models, a running desktop app, or the user's application database.

For Rust changes, install Rust stable and the [Tauri platform prerequisites](https://tauri.app/start/prerequisites/),
then run `npm run test:rust` (or focus with
`cargo test --locked --manifest-path src-tauri/Cargo.toml config::tests`).
`npm test` combines web and Rust tests; [test CI](.github/workflows/tests.yml)
uses Linux for web tests and macOS for Rust. `npm run build` typechecks and builds
the frontend; `npm run tauri -- build` additionally packages the native app.
There is no configured standalone lint or formatter-check script.

[`.codex/verify.commands`](.codex/verify.commands) remains the broader verification
authority, including Git guards and performance baselines. Use its runner from a
feature branch and report those native/performance lanes separately from a focused
web smoke. Avoid cleanup and release/phase4 scripts as test setup.

For UI changes, use `npm run dev` for browser-only layout and keyboard checks.
Browser preview does not supply Tauri APIs; exercise command-backed loading,
empty, error, and success states in the mocked web tests. No browser test runner
is configured in this repository. `npm run dev:tauri` is a separate real
desktop check that uses application storage and needs the configured local model
service; model pulls and provider calls are not part of fixture verification.
