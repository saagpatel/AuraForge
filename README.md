# AuraForge

[![Rust](https://img.shields.io/badge/Rust-dea584?style=flat-square&logo=rust)](#) [![TypeScript](https://img.shields.io/badge/TypeScript-3178c6?style=flat-square&logo=typescript)](#) [![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](#)

> Turn a rough app idea into a fully scoped engineering spec — locally, privately, and fast enough to do it before you lose the spark.

AuraForge is a native desktop app built on Tauri + React + Rust. It acts as your AI planning partner during the *thinking* phase: you describe what you want to build, and AuraForge guides you through scope, architecture, data model, and edge cases until it can emit a comprehensive spec document that AI coding tools like Claude Code can execute with minimal guesswork.

Everything runs locally via Ollama. No data leaves your machine.

## Features

- **Structured planning conversations** — One topic at a time with a planning-focused system prompt that prevents scope creep and vague requirements
- **Codebase import** — Point AuraForge at an existing project and it incorporates the current state into planning context
- **Artifact generation** — Emits spec documents, architecture plans, task breakdowns, and coverage/confidence reports
- **Document linting** — Reviews generated artifacts for quality, completeness, and consistency before you hand them off
- **Diff tracking** — Compares artifact versions across sessions to show exactly what changed in the plan
- **Full local AI** — Powered by Ollama; pulls and switches models from within the app

## Quick Start

### Prerequisites

- Node.js 18+
- Rust stable toolchain (`rustup`)
- [Ollama](https://ollama.ai) installed and running locally
- Tauri system dependencies: [tauri.app/start/prerequisites](https://tauri.app/start/prerequisites/)

### Installation

```bash
git clone https://github.com/saagpatel/AuraForge
cd AuraForge
npm install
```

### Usage

```bash
# Start in development mode
npm run dev:tauri

# Or lean dev mode (lower disk usage, slower restarts)
npm run dev:lean
```

On first launch, the onboarding wizard guides you through connecting Ollama and pulling a model.

## Tech Stack

| Layer | Technology |
|-------|------------|
| Desktop shell | Tauri 2 |
| Frontend | React 19, TypeScript, Tailwind CSS 4, Zustand |
| Backend | Rust — document generation, linting, artifact diffing, search |
| Local AI | Ollama (any compatible model) |
| Storage | SQLite via rusqlite, local app data dir |
| Testing | Vitest, Testing Library |

## Architecture

AuraForge uses a clean Rust backend with dedicated modules for each concern: `docgen` generates structured artifacts, `lint` validates them, `artifact_diff` tracks changes across sessions, `importer` ingests codebases, and `llm` manages streaming Ollama conversations. The React frontend streams responses in real time and stores session history in a local SQLite database.

## License

MIT
