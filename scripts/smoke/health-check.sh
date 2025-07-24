#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8080}"

check_endpoint() {
  local name="$1"
  local url="$2"

  echo "Checking ${name}: ${url}"
  curl --fail --silent --show-error --max-time 10 "${url}" >/dev/null
}

check_endpoint "gateway health" "${BASE_URL}/actuator/health"
check_endpoint "gateway readiness" "${BASE_URL}/actuator/health/readiness"

echo "Smoke health checks passed."
