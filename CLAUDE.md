# AuraForge

## Stack

Tauri 2 + React + TypeScript + Vite + Tailwind + Vitest

## Key Commands

- `pnpm dev:tauri` — full Tauri dev (Rust + React)
- `pnpm dev:lean` — web-only (no Rust, fast iteration)
- `pnpm test` — Vitest (web), `pnpm test:rust` — Rust
- `pnpm release:tauri` — production build

## Architecture

- `src/` — React frontend (Vite, Tailwind)
- `src-tauri/` — Rust backend (Tauri 2, tokio, reqwest, serde)
- Frontend → Rust via `invoke()` from `@tauri-apps/api/core`
- Rust → Frontend via Tauri events (`emit`)

## Rules

- Tauri commands: `#[tauri::command]` in `src-tauri/src/lib.rs` or submodules, registered in `tauri::Builder`
- Never call external APIs from React — route through Rust commands instead
- Test files co-located: `Component.test.tsx` alongside `Component.tsx`
- Run `pnpm test` before considering any task complete

<!-- portfolio-context:start -->

# Portfolio Context

## What This Project Is

Tauri 2 desktop app for AI-assisted creative generation. React + TypeScript frontend, Rust backend with Tauri event bridge. Built with pnpm workspaces.

## Current State

Active development. Core Tauri scaffold with React/TypeScript frontend and Rust backend operational. Vitest (web) and cargo test (Rust) both configured.

## Stack

- **Desktop shell**: Tauri 2 (Rust backend + WebView)
- **Frontend**: React + TypeScript + Vite + Tailwind
- **Test**: Vitest (web), cargo test (Rust)
- **Build**: pnpm workspaces

## How To Run

```
pnpm install
pnpm dev:tauri
```

For web-only iteration: `pnpm dev:lean`. Tests: `pnpm test` (Vitest) and `pnpm test:rust` (Rust).

## Known Risks

- Tauri 2 API surface differs from v1 — do not port v1 patterns without checking migration guide
- Vitest and Rust tests run independently; CI must gate both
- Never call external APIs from React — route all network calls through Rust commands

## Next Recommended Move

Review the current implementation scope in CLAUDE.md and pick the next feature phase. Run both test suites before committing.

<!-- portfolio-context:end -->
