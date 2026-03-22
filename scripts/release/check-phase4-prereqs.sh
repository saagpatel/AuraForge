#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-saagpatel/AuraForge}"
FAIL=0

required_secrets=(
  "APPLE_CERTIFICATE"
  "APPLE_CERTIFICATE_PASSWORD"
  "APPLE_SIGNING_IDENTITY"
  "APPLE_ID"
  "APPLE_PASSWORD"
  "APPLE_TEAM_ID"
)

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: gh CLI is required."
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "ERROR: gh CLI is not authenticated."
  exit 1
fi

workflows_json="$(gh workflow list -R "${REPO}" --json name,path,state)"
secrets_json="$(gh secret list -R "${REPO}" --json name)"

has_release_workflow="no"
if echo "${workflows_json}" | node -e 'const fs=require("fs"); const d=JSON.parse(fs.readFileSync(0,"utf8")); const ok=d.some(w=>w.path==".github/workflows/release-rc.yml"||w.name=="release-rc"); process.exit(ok?0:1);'; then
  has_release_workflow="yes"
else
  has_release_workflow="no"
  FAIL=1
fi

missing_secrets=()
for secret_name in "${required_secrets[@]}"; do
  if ! echo "${secrets_json}" | node -e "const fs=require('fs'); const d=JSON.parse(fs.readFileSync(0,'utf8')); const found=d.some(s=>s.name==='${secret_name}'); process.exit(found?0:1);"; then
    missing_secrets+=("${secret_name}")
    FAIL=1
  fi
done

echo "Phase 4 prerequisite check for ${REPO}"
echo ""
echo "- release-rc workflow on default branch: ${has_release_workflow}"
if [[ ${#missing_secrets[@]} -eq 0 ]]; then
  echo "- required APPLE_* secrets: present"
else
  echo "- required APPLE_* secrets: missing"
  for secret_name in "${missing_secrets[@]}"; do
    echo "  - ${secret_name}"
  done
fi

if [[ "${FAIL}" -ne 0 ]]; then
  exit 1
fi
