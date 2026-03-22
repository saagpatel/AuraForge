#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-saagpatel/AuraForge}"
STATUS=0

echo "== Phase 4 Gate Pack =="
echo ""

echo "[1/3] Engineering baseline"
if bash .codex/scripts/run_verify_commands.sh; then
  echo "PASS: engineering baseline"
else
  echo "FAIL: engineering baseline"
  STATUS=1
fi

echo ""
echo "[2/3] Security baseline"
if npm audit --json >/tmp/auraforge-audit.json; then
  echo "PASS: security baseline"
else
  echo "FAIL: security baseline"
  STATUS=1
fi

echo ""
echo "[3/3] Release prerequisites"
if bash scripts/release/check-phase4-prereqs.sh "${REPO}"; then
  echo "PASS: release prerequisites"
else
  echo "FAIL: release prerequisites"
  STATUS=1
fi

echo ""
if [[ "${STATUS}" -eq 0 ]]; then
  echo "Phase 4 gate pack: PASS"
else
  echo "Phase 4 gate pack: FAIL"
fi

exit "${STATUS}"
