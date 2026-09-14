#!/usr/bin/env bash
set -euo pipefail

TAG="v15-25-CLOSED-79140147"
EXPECTED_SHA="79140147ba92fe290b4178f92ff7d77ec3271198"
EXPECTED_REF="refs/tags/${TAG}"

show_ref_output="$(git show-ref --tags | grep -F "${EXPECTED_REF}" || true)"
if [[ -z "${show_ref_output}" ]]; then
  echo "ERROR: missing ${EXPECTED_REF}" >&2
  exit 1
fi

peeled_sha="$(git rev-parse "${TAG}^{}")"
if [[ "${peeled_sha}" != "${EXPECTED_SHA}" ]]; then
  echo "ERROR: ${EXPECTED_REF} peels to ${peeled_sha}, expected ${EXPECTED_SHA}" >&2
  exit 1
fi

echo "OK: ${EXPECTED_REF} -> ${EXPECTED_SHA}"
git show --no-patch --decorate "${TAG}"
