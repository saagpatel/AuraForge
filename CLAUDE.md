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
