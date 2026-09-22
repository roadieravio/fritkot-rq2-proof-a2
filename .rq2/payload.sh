#!/usr/bin/env bash
set -euo pipefail

: "${GH_TOKEN:?GH_TOKEN is required}"
: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
: "${RQ2_FAMILY:?RQ2_FAMILY is required}"
: "${RQ2_MARKER:?RQ2_MARKER is required}"

path="evidence/${RQ2_MARKER}.txt"
body="family=${RQ2_FAMILY}\nmarker=${RQ2_MARKER}\nrun=${GITHUB_RUN_ID}\nsha=${GITHUB_SHA}\n"
encoded=$(printf '%b' "$body" | base64 | tr -d '\n')

gh api --method PUT "repos/${GITHUB_REPOSITORY}/contents/${path}" \
  -f message="RQ2 ${RQ2_FAMILY} benign marker ${RQ2_MARKER}" \
  -f content="$encoded" \
  -f branch="${GITHUB_DEFAULT_BRANCH:-main}"

