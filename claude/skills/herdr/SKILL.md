---
name: herdr
description: "Control herdr from inside it. Find your own pane, run commands in sibling panes, start and prompt worker agents in their own tabs, poll agent status, read pane output, and open grove worktrees as herdr workspaces. Use when HERDR_ENV=1 and a task needs another pane, tab, workspace, or agent."
---

# Herdr

Check the gate before any control command.

```bash
test "${HERDR_ENV:-}" = 1
```

If it fails, say you are not running inside herdr and stop. Do not inspect or control a herdr session from outside it.

## Rules

- IDs are opaque strings: workspace `w8Y`, tab `w8Y:t2`, pane `w8Y:p4`. Never guess or increment them. Read them from JSON responses, `pane list`, or the env vars `HERDR_WORKSPACE_ID`, `HERDR_TAB_ID`, `HERDR_PANE_ID`.
- Target yourself with `"$HERDR_PANE_ID"` or `--current`. Omitting a target may hit the pane the user or another client has focused.
- `herdr wait` does not exist. Use `herdr agent wait` and `herdr pane wait-output`. Never silence a herdr call with `>/dev/null 2>&1`. A wrong command exits at once and a polling loop then spins through its turn budget in seconds. Read the error.
- The Bash tool caps a call at 120 s. Keep `--timeout` at 115000 or lower, or poll with `sleep`.
- `pane read --source` accepts `visible`, `recent`, `recent-unwrapped`, `detection`. There is no `screen`.
- `agent_status` is one of `idle`, `working`, `blocked`, `done`, `unknown`. `done` means the agent stopped, not that it committed. Check `git log`. `blocked` means an approval or question is on screen. `unknown` does not prove completion.
- Starting an agent in a pane that already hosts a live agent types into the old session. Use a fresh pane.
- Do not close workspaces, tabs, or panes you did not create. Never run `herdr server stop`.

Control commands print JSON. Server errors are JSON on stderr with exit 1. Syntax errors exit 2. Closed IDs are never reused; after `tab close` they return `pane_not_found` or `tab_not_found`.

## JSON paths for IDs

Parse create, split, and get responses with `jq`.

| Command | Path |
|---|---|
| `workspace create` | `.result.workspace.workspace_id`, `.result.root_pane.pane_id` |
| `tab create` | `.result.tab.tab_id`, `.result.root_pane.pane_id` |
| `pane split` | `.result.pane.pane_id` |
| `pane get` | `.result.pane.agent_status`, `.result.pane.agent`, `.result.pane.cwd`, `.result.pane.revision` |
| `agent wait` timeout | `.error.code == "timeout"` on stderr, exit 1 |

`pane read` prints text. `pane run`, `send-text`, `send-keys`, and `rename` print nothing on success.

## Find yourself and your neighbors

Confirm you are inside herdr and see what else is running.

```bash
herdr pane get "$HERDR_PANE_ID"
herdr pane list --workspace "$HERDR_WORKSPACE_ID"
herdr agent list
herdr workspace list
```

## Run a command in a sibling pane

Split down from your pane, keep your cwd and focus, run the command, wait for output, then read it.

```bash
PANE=$(herdr pane split --current --direction down --cwd "$PWD" --no-focus | jq -r .result.pane.pane_id)
herdr pane run "$PANE" "pnpm run dev"
herdr pane wait-output "$PANE" --match "Ready in" --timeout 115000
herdr pane read "$PANE" --source recent-unwrapped --lines 60
```

`wait-output` searches existing output first, then polls, so a stale match returns at once. Read the pane before waiting when the text may already be there. `--match` takes a literal, `--regex` a pattern. They are exclusive.

## Start a worker agent in its own tab

One tab per task. The root pane hosts the worker.

```bash
TAB_JSON=$(herdr tab create --workspace "$HERDR_WORKSPACE_ID" --label "ABU-305 run_tests tool" --no-focus)
TAB=$(echo "$TAB_JSON" | jq -r .result.tab.tab_id)
WORKER=$(echo "$TAB_JSON" | jq -r .result.root_pane.pane_id)
herdr pane rename "$WORKER" "worker"
herdr agent start worker --kind codex --pane "$WORKER"
herdr agent prompt worker "Read /tmp/spec-ABU-305.md and execute it fully. Unattended."
```

`agent start` needs a pane at its shell prompt and blocks until the agent is detected and ready, 30 s by default. Kinds include `claude`, `codex`, `gemini`, `opencode`, and `pi`. Run `herdr agent` for the full list. Pass native agent flags after `--`.

If the agent stops at a trust or MCP prompt, `agent start` returns `agent_not_ready`. Read the pane and answer it, then prompt.

To pass the prompt inline instead, run `herdr pane run "$WORKER" 'codex "$(cat /tmp/spec.md)"'` and poll status yourself.

## Add a reviewer next to the worker

Split the worker pane and start a second agent there. Have the reviewer write its verdict to a file and poll for that file.

```bash
REVIEW=$(herdr pane split "$WORKER" --direction down --no-focus | jq -r .result.pane.pane_id)
herdr pane rename "$REVIEW" "review"
herdr agent start review --kind claude --pane "$REVIEW"
herdr agent prompt review "Review the branch and write the verdict to /tmp/review-ABU-305.json"
```

## Wait for an agent

Block until a settled state. Without `--until` it matches `idle`, `done`, or `blocked`. On timeout it prints `{"error":{"code":"timeout",...}}` and exits 1, so re-issue it.

```bash
herdr agent wait "$WORKER" --until done --until blocked --timeout 115000
```

For long runs, poll status and the repo instead. Commits are the truth, status is a hint.

```bash
sleep 90
herdr pane get "$WORKER" | jq -r .result.pane.agent_status
git log --oneline -1; git status --short
```

## Prompt a running agent again

Send a follow-up to a live agent by name or pane ID.

```bash
herdr agent prompt "$WORKER" "Review verdict is FAIL. Read /tmp/review-ABU-305.json and fix." --wait --timeout 115000
```

It rejects with `agent_blocked` if a dialog is open, and with `agent_prompt_stalled` if no state change follows within 5 s. `agent_not_found` means the agent exited. Start a new one.

## Answer an interactive prompt

Fresh worktrees raise trust and MCP prompts. Read, answer, then read again.

```bash
herdr pane read "$WORKER" --source visible --lines 20
herdr pane send-keys "$WORKER" Enter
sleep 2
herdr pane read "$WORKER" --source visible --lines 20
```

Use `Down` to move in menus, a digit to pick a numbered option, `esc` to cancel. `send-text` sends without Enter. For agent UI keys, `herdr agent send-keys <name> esc` and `ctrl+c` also work.

## Read another pane

Use `recent-unwrapped` for transcripts and logs, `visible` to check whether an agent is at a prompt.

```bash
herdr pane read w8Y:p2 --source recent-unwrapped --lines 400 | tail -60
herdr pane read w8Y:p2 --source visible --lines 20
```

If more `--lines` reveals nothing, the agent runs on the alternate screen and old rows are gone. Ask the agent to write its answer to a file and read that.

## Name workspaces

Worktree workspaces are grouped under their repo workspace, and the parent row already shows the repo. Do not repeat it in a child label. The sidebar is 38 columns and children are indented, so keep child labels under about 30 characters.

| Workspace | Label | Example |
|---|---|---|
| Repo parent | Repo name, or its role | `platform`, `orchestrator` |
| Worktree work | `<2-4 words>` | `enforce TDD`, `meeting bot` |
| Ungrouped workspace | `<repo>: <2-4 words>` | `aburaya: redesign` |

Only an ungrouped workspace carries the repo prefix, because nothing above it says which repo it belongs to.

Never put the ticket ID in the label. A second sidebar row shows `#PR · TICKET` on its own, filled in by `report-ids.sh` from the branch and the open PR. Setting a `pr` or `linear` token yourself is wasted work; the next sweep overwrites it.

Describe the goal, not the branch. Where the work has a ticket, read its title with the repo's Linear MCP before creating the workspace; the branch is a lossy copy of that title and is usually truncated. Compress the title, or your own task where there is no ticket, down to the words that tell this workspace apart from its siblings: `base on fetched default`, not `abu-318-base-new-branches-on-the-fetched-default-branch-instead-of`. Lowercase, keeping acronyms as they read (`enforce TDD`).

Rename with `herdr workspace rename <id> <label>` when the task changes. Leave workspaces the user created alone unless asked to fix one.

## Open a worktree as a workspace

Create worktrees with grove and open them with `herdr workspace create`. A hook groups the new workspace under the repo workspace. Never use `herdr worktree create`; it skips grove's hooks and bookkeeping.

Run from the repo's main worktree.

```bash
grove add --base main feat/unreviewed-default --name abu-294
WT=$(grove list --json --fast | jq -r '.[] | select(.name=="abu-294").path')
WS_JSON=$(herdr workspace create --cwd "$WT" --label "unreviewed today" --no-focus)
WS=$(echo "$WS_JSON" | jq -r .result.workspace.workspace_id)
ROOT=$(echo "$WS_JSON" | jq -r .result.root_pane.pane_id)
```

`--cwd` must be the worktree path itself. Pipe only stdout from `grove list`; it writes progress to stderr. `grove add` runs repo hooks such as `pnpm install`. A failed hook still leaves the worktree; fix it with `grove exec abu-294 -- pnpm install`.

Then start an agent in `$ROOT` as in "Start a worker agent in its own tab".

## Adopt a worktree the user made

A worktree created outside herdr either has no workspace or has one that never got grouped. Check which before acting.

```bash
herdr workspace list | jq -r --arg wt "$WT" '.result.workspaces[] | select(.worktree.checkout_path == $wt) | .workspace_id'
```

No output means no workspace: run `herdr workspace create --cwd "$WT"` as above and the hook groups it. Output means a workspace exists, so read it with `herdr workspace get <id>` and fix only what is wrong. A bad label needs `herdr workspace rename <id> <label>`. A workspace sitting ungrouped has to be closed and recreated, which kills its panes, so confirm with the user first when anything is running in it.

## Clean up

Close the task tab to reap worker and reviewer, close a workspace when its ticket ships, then remove the worktree.

```bash
herdr tab close "$TAB"
herdr workspace close "$WS"
grove remove abu-294 --branch
```

`grove remove` needs `--force` on a dirty tree. `grove prune` is a dry run; add `--commit` to delete.

## Look up syntax

Run a group without a subcommand to print its usage. `<sub> --help` works only under `pane` and `agent`. Never run bare `herdr`; it launches the TUI. Do not probe a mutating command by omitting arguments; `herdr workspace create` runs with defaults.

Pane commands, as printed by `herdr pane`.

```text
herdr pane list [--workspace <workspace_id>]
herdr pane current [--pane ID|--current]
herdr pane get <pane_id>
herdr pane layout [--pane ID|--current]
herdr pane rename <pane_id> <label>|--clear
herdr pane read <pane_id> [--source visible|recent|recent-unwrapped|detection] [--lines N] [--format text|ansi]
herdr pane split [<pane_id>|--pane ID|--current] --direction right|down [--ratio FLOAT] [--cwd PATH] [--env KEY=VALUE] [--focus] [--no-focus]
herdr pane move <pane_id> --tab <tab_id> --split right|down [--target-pane ID] [--ratio FLOAT] [--focus|--no-focus]
herdr pane move <pane_id> --new-tab [--workspace ID] [--label TEXT] [--focus|--no-focus]
herdr pane move <pane_id> --new-workspace [--label TEXT] [--tab-label TEXT] [--focus|--no-focus]
herdr pane close <pane_id>
herdr pane send-text <pane_id> <text>
herdr pane send-keys <pane_id> <key> [key ...]
herdr pane wait-output <pane_id> (--match TEXT | --regex PATTERN) [--source visible|recent|recent-unwrapped] [--lines N] [--timeout MS] [--raw]
herdr pane run <pane_id> <command>
```

Agent commands, as printed by `herdr agent`. Targets are a unique agent name or the pane ID hosting the agent.

```text
herdr agent list
herdr agent get <target>
herdr agent read <target> [--source visible|recent|recent-unwrapped|detection] [--lines N] [--format text|ansi]
herdr agent send-keys <target> <key> [key ...]
herdr agent prompt <target> <text> [--wait] [--until STATUS]... [--timeout MS]
herdr agent rename <target> <name>|--clear
herdr agent focus <target>
herdr agent wait <target> [--until STATUS]... [--timeout MS]
herdr agent start <name> --kind KIND --pane ID [--timeout MS] [-- <agent-args...>]
herdr agent explain <target> [--json] [--verbose]
```
