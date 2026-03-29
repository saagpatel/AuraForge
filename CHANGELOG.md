# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-03-21

### Added
- Branch sessions from any message
- Local codebase context import for planning
- Template-driven session bootstrap
- OpenAI-compatible local runtime support
- Planning coverage analysis and sidebar
- Generation confidence scoring
- Model-targeted forging with readiness checks
- Target-aware forge metadata and handoff
- Planning tools and multi-provider LLM support
- Inline sidebar rename and background document generation
- Multi-select session deletion in sidebar
- Non-technical user experience, production build, and distribution
- Visual components: ember particles, forging UX, toast
- Main app layout with split-pane chat and document view
- All UI components, TypeScript types, and Zustand store
- Tauri command handlers for all app operations
- Document generation from conversation context
- Web search with Tavily and DuckDuckGo fallback
- Ollama LLM client with streaming and health checks
- Core data layer: types, config, state, and SQLite database
- Tauri backend scaffold with config, DB, and app bootstrap
- Planning OS expansion and closure follow-ups
- CI: publish test and RC lanes, Linux checks, and bundle workflow

### Fixed
- Pin AuraForge Rust toolchain
- Avoid ripgrep dependency in invariant check step
- Use correct Ollama model tag for qwen3-coder
- Harden backend and improve frontend quality across 14 review findings
- Harden export paths and config atomic writes
- Fail interrupted streams instead of returning partial success
- Prevent stale async state races in chat store
- Order message reads and retries by insertion
- Avoid partial plan folders on write failures
- Correct default model tag to match Ollama registry
- Add rename_all snake_case to all Tauri commands
- Replace current_date placeholder in docgen system prompt
- Prevent double rename commit and memoize derived state
- Settings panel trapped in sidebar stacking context with broken overlay dismiss
- Resolve 5 remaining known issues from test report
- Comprehensive audit fixes across backend and frontend
- Default config uses DuckDuckGo when Tavily key is absent
- Harden disk space math for Unix type variance and Linux Clippy type mismatch
- Strengthen transaction safety in retry flows
- Replace generic runtime errors with typed validation
- Restore optional Tavily provider support
- Enforce local-only and free provider defaults

### Changed
- Normalize local provider contract handling
- Cap file reads and enforce frontend tests in CI
- Harden search fallback and operation gating
- Tighten Tauri CSP and runtime permissions
- Add async race coverage for chat store
- Add deterministic manifest file metadata
- Polish local runtime setup and CI trigger
- Finalize Codex OS bootstrap baseline and guardrails
- Add lean development and cleanup workflows
- Trim Rust metadata and lockfile
- Aggressively prune non-runtime assets
- Add definitive implementation plan
- Refresh app state, capabilities, and README
- Add runbook and finalize implementation closure
- Overhaul document generation prompts and add cross-referencing
- Update README for v0.2.0 six-document pipeline
- Add design system spec and project documentation
