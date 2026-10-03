# AuraForge

## Stack

Tauri 2 + React + TypeScript + Vite + Tailwind + Vitest

## Key Commands

npm is the package manager: CI (`.github/workflows/tests.yml`, `release-rc.yml`), `.codex/verify.commands` and every package.json script use npm with `package-lock.json`.

- `npm ci` — install from the lockfile
- `npm run dev:tauri` — full Tauri dev (Rust + React)
- `npm run dev:lean` — same Tauri dev, but with throwaway Cargo/Vite caches in a temp dir (lower disk use, slower restarts)
- `npm run dev` — Vite only, browser preview without Rust
- `npm test` — web (Vitest) then Rust; `npm run test:web`, `npm run test:smoke`, `npm run test:rust` run each lane alone
- `npm run build` — typecheck + frontend build
- `npm run release:tauri` — production build

## Architecture

- `src/` — React frontend (Vite, Tailwind)
- `src-tauri/` — Rust backend (Tauri 2, tokio, reqwest, serde)
- Frontend → Rust via `invoke()` from `@tauri-apps/api/core`
- Rust → Frontend via Tauri events (`emit`)

## Rules

- Tauri commands: `#[tauri::command]` in `src-tauri/src/lib.rs` or submodules, registered in `tauri::Builder`
- Never call external APIs from React — route through Rust commands instead
- Web tests live in `src/components/__tests__/` and `src/test/smoke/`; Rust tests are in-module `#[cfg(test)]`
- Run `npm test` before considering any task complete

<!-- portfolio-context:start -->

# Portfolio Context

## What This Project Is

Tauri 2 desktop app for AI-assisted creative generation. React + TypeScript frontend, Rust backend with Tauri event bridge. Single npm package (not a workspace).

## Current State

Active development. Core Tauri scaffold with React/TypeScript frontend and Rust backend operational. Vitest (web) and cargo test (Rust) both configured.

## Stack

- **Desktop shell**: Tauri 2 (Rust backend + WebView)
- **Frontend**: React + TypeScript + Vite + Tailwind
- **Test**: Vitest (web), cargo test (Rust)
- **Build**: npm (`package-lock.json`), Vite, Tauri CLI

## How To Run

```bash
npm ci
npm run dev:tauri
```

For browser-only iteration: `npm run dev`. Tests: `npm test` runs Vitest and then `cargo test`; `npm run test:web` and `npm run test:rust` run them separately.

## Known Risks

- Tauri 2 API surface differs from v1 — do not port v1 patterns without checking migration guide
- Vitest and Rust tests run independently; CI must gate both
- Never call external APIs from React — route all network calls through Rust commands

## Next Recommended Move

Review the current implementation scope in CLAUDE.md and pick the next feature phase. Run both test suites before committing.

<!-- portfolio-context:end -->
