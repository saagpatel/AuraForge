#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-saagpatel/AuraForge}"
FAIL=0

required_signing_secrets=(
  "APPLE_CERTIFICATE"
  "APPLE_CERTIFICATE_PASSWORD"
  "APPLE_SIGNING_IDENTITY"
  "APPLE_TEAM_ID"
)

apple_id_notary_secrets=(
  "APPLE_ID"
  "APPLE_PASSWORD"
)

api_key_notary_secrets=(
  "APPLE_API_KEY_ID"
  "APPLE_API_ISSUER"
  "APPLE_API_PRIVATE_KEY"
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

missing_signing_secrets=()
for secret_name in "${required_signing_secrets[@]}"; do
  if ! echo "${secrets_json}" | node -e "const fs=require('fs'); const d=JSON.parse(fs.readFileSync(0,'utf8')); const found=d.some(s=>s.name==='${secret_name}'); process.exit(found?0:1);"; then
    missing_signing_secrets+=("${secret_name}")
    FAIL=1
  fi
done

missing_apple_id_notary_secrets=()
for secret_name in "${apple_id_notary_secrets[@]}"; do
  if ! echo "${secrets_json}" | node -e "const fs=require('fs'); const d=JSON.parse(fs.readFileSync(0,'utf8')); const found=d.some(s=>s.name==='${secret_name}'); process.exit(found?0:1);"; then
    missing_apple_id_notary_secrets+=("${secret_name}")
  fi
done

missing_api_key_notary_secrets=()
for secret_name in "${api_key_notary_secrets[@]}"; do
  if ! echo "${secrets_json}" | node -e "const fs=require('fs'); const d=JSON.parse(fs.readFileSync(0,'utf8')); const found=d.some(s=>s.name==='${secret_name}'); process.exit(found?0:1);"; then
    missing_api_key_notary_secrets+=("${secret_name}")
  fi
done

has_apple_id_notary="no"
has_api_key_notary="no"
if [[ ${#missing_apple_id_notary_secrets[@]} -eq 0 ]]; then
  has_apple_id_notary="yes"
fi
if [[ ${#missing_api_key_notary_secrets[@]} -eq 0 ]]; then
  has_api_key_notary="yes"
fi
if [[ "${has_apple_id_notary}" != "yes" && "${has_api_key_notary}" != "yes" ]]; then
  FAIL=1
fi

echo "Phase 4 prerequisite check for ${REPO}"
echo ""
echo "- release-rc workflow on default branch: ${has_release_workflow}"
if [[ ${#missing_signing_secrets[@]} -eq 0 ]]; then
  echo "- required signing secrets: present"
else
  echo "- required signing secrets: missing"
  for secret_name in "${missing_signing_secrets[@]}"; do
    echo "  - ${secret_name}"
  done
fi
if [[ "${has_apple_id_notary}" == "yes" || "${has_api_key_notary}" == "yes" ]]; then
  echo "- notarization credentials: present"
else
  echo "- notarization credentials: missing"
  echo "  - provide either APPLE_ID + APPLE_PASSWORD"
  echo "  - or APPLE_API_KEY_ID + APPLE_API_ISSUER + APPLE_API_PRIVATE_KEY"
fi

if [[ "${FAIL}" -ne 0 ]]; then
  exit 1
fi
