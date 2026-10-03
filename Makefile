.PHONY: build test lint clean check run

# Rust crate lives in src-tauri/; there is no Cargo.toml at the repo root.
MANIFEST := --manifest-path src-tauri/Cargo.toml

build:
	cargo build $(MANIFEST) --release

check:
	cargo check $(MANIFEST)

test:
	cargo test $(MANIFEST)

lint:
	cargo clippy $(MANIFEST) -- -D warnings

run:
	cargo run $(MANIFEST)

clean:
	cargo clean $(MANIFEST)
