#!/usr/bin/env bash
set -euo pipefail

# Report display-only PR and Linear tokens. Prefer a ticket from the open PR's
# closing lines; fall back to the branch when none is found.

readonly source_id="pr-ids"
# Linear team keys, lowercase. A generic letters-digits pattern also matches
# content such as `chore/round-1-shave` and ADR numbering such as `adr-029-*`.
readonly ticket_keys="abu|hup|ai|tms"
# Expire tokens after three missed timer intervals to avoid stale IDs.
readonly ttl_ms=900000
readonly gh_timeout=15

for tool in gh jq herdr; do
  if ! command -v "${tool}" > /dev/null 2>&1; then
    echo "report-ids: ${tool} not found" >&2
    exit 1
  fi
done

ticket_from_branch() {
  local branch
  branch="$(git -C "${1}" rev-parse --abbrev-ref HEAD 2> /dev/null)" || return 0
  grep -m1 -oiE "^(${ticket_keys})-[0-9]+" <<< "${branch##*/}" | tr '[:lower:]' '[:upper:]'
}

report_workspace() {
  local workspace_id="${1}"
  local checkout_path="${2}"
  local pr state number
  local linear=""
  local args=()

  # gh may return a merged or closed PR, so check its state.
  # Treat "no pull requests found" as absent. On other errors, leave existing
  # tokens untouched and let their TTL expire.
  if pr="$(cd "${checkout_path}" && timeout "${gh_timeout}" gh pr view --json number,state,body 2>&1)"; then
    state="$(jq -r '.state // empty' <<< "${pr}")"
  elif grep -q 'no pull requests found' <<< "${pr}"; then
    state=""
  else
    return 0
  fi

  args=(workspace report-metadata "${workspace_id}" --source "${source_id}"
    --seq "$(date +%s%N)")

  if [[ "${state}" == "OPEN" ]]; then
    number="$(jq -r '.number // empty' <<< "${pr}")"
    # Read tickets only from lines starting with fixes, closes, or resolves.
    # Cape puts the human ticket before the plan issue.
    linear="$(jq -r '.body // empty' <<< "${pr}" \
      | grep -iE '^(fixes|closes|resolves)' \
      | grep -oiE "\b(${ticket_keys})-[0-9]+\b" | tr '[:lower:]' '[:upper:]')" || linear=""
    # Keep the first match without risking SIGPIPE from head under pipefail.
    linear="${linear%%$'\n'*}"

    args+=(--token "pr=#${number}")
  else
    args+=(--clear-token pr)
  fi

  # Fall back to a recognized branch ticket when the open PR provides none.
  if [[ -z "${linear}" ]]; then
    linear="$(ticket_from_branch "${checkout_path}")" || linear=""
  fi

  args+=(--ttl-ms "${ttl_ms}")
  if [[ -n "${linear}" ]]; then
    args+=(--token "linear=${linear}")
  else
    args+=(--clear-token linear)
  fi

  # Sidebar updates are optional; one failed report must not stop the rest.
  herdr "${args[@]}" > /dev/null 2>&1 || true
}

main() {
  local workspaces

  if ! workspaces="$(herdr workspace list 2> /dev/null)"; then
    echo "report-ids: no herdr server" >&2
    exit 0
  fi

  # Report every id before the slow gh lookups so new workspaces show theirs at
  # once. Separate source without TTL: the id is stable, so a gh failure must
  # not expire it.
  while read -r workspace_id; do
    herdr workspace report-metadata "${workspace_id}" --source workspace-id \
      --seq "$(date +%s%N)" --token "id=${workspace_id}" > /dev/null 2>&1 || true
  done < <(jq -r '.result.workspaces[].workspace_id' <<< "${workspaces}")

  # Look up every checkout at once; sequential gh calls take seconds each.
  while IFS=$'\t' read -r workspace_id checkout_path; do
    report_workspace "${workspace_id}" "${checkout_path}" &
  done < <(jq -r '
    .result.workspaces[]
    | select(.worktree.checkout_path)
    | [.workspace_id, .worktree.checkout_path]
    | @tsv
  ' <<< "${workspaces}")
  wait
}

main "$@"
