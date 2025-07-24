#!/bin/bash
# Format markdown files with prettier after Claude Code writes them

set -euo pipefail

# Fail early if essential tools are missing.
if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq command not found. Please install jq." >&2
  exit 1
fi

if ! command -v prettier >/dev/null 2>&1; then
  echo "Error: prettier command not found. Please install prettier." >&2
  exit 1
fi

# Debug logging (uncomment for troubleshooting).
# DEBUG_LOG="/tmp/claude-hooks-debug.log"
# echo "[$(date)] Hook triggered" >> "$DEBUG_LOG"

if ! INPUT=$(cat); then
  echo "Error: Failed to read input from stdin" >&2
  exit 1
fi

if ! FILE_PATH=$(echo "${INPUT}" | jq -r '.tool_input.file_path // empty' 2>/dev/null); then
  echo "Error: Failed to parse JSON input" >&2
  exit 1
fi

# Claude Code versions may use different JSON structures.
if [[ -z "${FILE_PATH}" || "${FILE_PATH}" == "null" ]]; then
  # Try alternative parsing methods.
  FILE_PATH=$(echo "${INPUT}" | jq -r '.file_path // empty' 2>/dev/null) || true
fi

# Debug logging (uncomment for troubleshooting).
# echo "[$(date)] Processing file: ${FILE_PATH}" >> "$DEBUG_LOG"

if [[ -n "${FILE_PATH}" && -f "${FILE_PATH}" && "${FILE_PATH}" == *.md ]]; then
  if prettier --write "${FILE_PATH}" 2>/dev/null; then
    # Optional: Output JSON response (uncomment if needed).
    # echo '{"reason": "Markdown file formatted with Prettier", "decision": "approve"}'
    exit 0
  else
    echo "Warning: Prettier formatting failed for ${FILE_PATH}" >&2
    exit 1
  fi
fi

# Non-markdown files should not trigger formatting.
exit 0
