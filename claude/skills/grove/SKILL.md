---
name: grove
description: "Create, inspect, run commands in, and clean up git worktrees with grove. Use when the user wants a branch or PR in its own worktree, a command run in another worktree or across all of them, a per-ticket worktree plus herdr workspace, or stale worktrees removed. grove is the interface. Do not use raw `git worktree`."
---

# Grove

grove manages git worktrees. Use it for all worktree work instead of raw `git worktree`. The `grove` binary is on PATH. Run `grove <command> --help` for flags not listed here.

A workspace is one directory per repo holding `.bare/` (git data) plus one subdirectory per worktree, for example `aburaya/main` and `aburaya/abu-294`. `main` is a worktree like any other, though `.grove.toml` may autolock it. `<wt>` arguments take the directory name or the branch name.

## Rules

- Each Bash call is a fresh shell, so `grove switch` (and `grove add -s`) never persists across calls. To act inside a worktree, use `grove exec <wt> -- <cmd>` or `cd <path> && <cmd>` in one call. Take paths from `grove list --json`. Never assume your cwd between calls.
- `grove list` works from anywhere in the workspace. `grove status` needs cwd inside a worktree. From the workspace root it fails with "must be run in a work tree".
- `grove list --json` prints a progress line to stderr. Pipe stdout only into jq. `2>&1` breaks the parse.
- `grove prune` is a dry run. Removal needs `--commit`.
- There is no `--branch` flag on `add`. The branch is the positional argument and `--name` sets the directory.
- `grove add` runs the `hooks.add` commands from `.grove.toml` (often `pnpm install`). A failed hook still leaves the worktree in place. Rerun the hook with `grove exec`, not `grove add`.

## Discover state

List worktrees as JSON, then pick the path you need.

```bash
grove list --json --fast
grove list --json --fast | jq -r '.[] | select(.name == "abu-294") | .path'
```

Each object has `name` (directory), `branch`, `path` (absolute), `current`, and flags present only when set: `dirty`, `upstream` or `no_upstream`, `ahead`, `behind`, `gone`, `locked`, `lock_reason`, `last_commit`. Treat absent flags as false. `--fast` skips dirty and sync checks and drops `dirty`, `upstream`, `no_upstream`, `ahead`, `behind`, `gone`, and `last_commit`. `--filter` accepts `dirty`, `ahead`, `behind`, `gone`, `locked`. `--sort recent` orders by last commit. Pass `--plain` on any non-JSON output you parse or echo. Do not create a worktree just to inspect one.

Status of another worktree without changing cwd.

```bash
grove exec <wt> -- grove status --json
```

## Add a worktree

The directory defaults to the branch name with `/` replaced by `-`. `--base` defaults to the default branch.

| Goal | Command |
| --- | --- |
| New or existing branch off the default branch | `grove add feat/x` |
| Different base | `grove add --base origin/main feat/x` |
| Short directory name | `grove add feat/abu-294-unreviewed-default --name abu-294` |
| Carry uncommitted changes from another worktree | `grove add --from <wt> feat/x` |
| Check out a PR into `./pr-123` | `grove add --pr 123` (`--reset` if the branch diverged) |
| Offline | `grove add --no-fetch feat/x` |

Name the directory yourself with `--name`. Grove derives it from the branch otherwise, which produces long names truncated mid-word, such as `abu-318-base-new-branches-on-the-fetched-default-branch-instead-of`. Use the bare ticket ID for ticket work (`abu-294`) and a two or three word slug otherwise (`meeting-bot`). Keep the full description in the branch name, where length costs nothing.

```bash
grove add feat/abu-294-default-unreviewed-today --name abu-294
```

The directory name is what `grove exec`, `grove remove`, and every other command take as `<wt>`, so short names pay off on every later call. Keep it stable: if the branch is renamed, the directory keeps its old name and drifts out of sync.

`grove add` on a branch that already has a worktree fails with "worktree already exists". Check `grove list` first.

## Run a command in another worktree

Use `grove exec` so cwd does not matter.

```bash
grove exec abu-294 -- pnpm install --frozen-lockfile
grove exec fix-thing -- git diff --stat
grove exec main -- git branch -d fix/thing
grove exec --all -- npm ci
grove exec --all --fail-fast -- go build ./...
```

`grove exec --json` returns per-worktree results. "All N executions failed" means the command itself failed inside the worktree, not grove.

## Clean up

Remove a finished worktree with its branch, then remove every worktree whose upstream is gone.

```bash
grove remove abu-294 --branch
grove prune --commit
```

`grove remove` refuses dirty or locked worktrees. Add `--force` only when the changes are disposable. `grove prune` takes `--merged`, `--stale 30d`, and `--force` as opt-ins. If `main` is autolocked, run `grove unlock main` before removing it. Protect others with `grove lock <wt> --reason "..."`.

## Workspace

`not in a grove workspace` means cwd is outside one. `cd` into a worktree, or create one with `grove clone <url|pr-url>`, `grove init new [dir]`, or `grove init convert`. Bare `grove init` only prints usage. `grove doctor` diagnoses a broken workspace. `grove config list` shows the effective config.

## Inside herdr

Skip this section unless `HERDR_ENV` is `1`. Then herdr is the multiplexer and every worktree gets its own herdr workspace, grouped under the repo. A herdr hook adopts any workspace whose first pane sits in a linked worktree, so `herdr workspace create --cwd <worktree path>` is enough.

Decide who does the work before creating anything. Creating a workspace does not start an agent; the root pane is a bare shell in the worktree. Either launch an agent into `root_pane` and hand it the task (see the herdr skill), or skip the workspace and work in the worktree from the pane you are already in. A per-ticket workspace with nothing running reads as work in progress that is not happening.

Create the worktree with grove, then open it as a background workspace and keep the ids.

```bash
grove add --base main feat/abu-294-unreviewed-default --name abu-294
path=$(grove list --json --fast | jq -r '.[] | select(.name == "abu-294") | .path')
herdr workspace create --cwd "${path}" --label "unreviewed today" --no-focus \
  | jq -r '.result.workspace.workspace_id, .result.root_pane.pane_id'
```

For several tickets, loop over `"<id>|<branch>|<label>"` specs and run the same two commands per entry.

- Pass the worktree path itself as `--cwd`, not a subdirectory.
- `grove add` alone is enough when you are doing the work yourself. Create the workspace when an agent will live in it, or when the human asked for one.
- Never run `herdr worktree create`. It skips grove entirely, so hooks, preserve patterns, autolock, and grove's bookkeeping do not apply.
- Removing the worktree with `grove remove` does not close the herdr workspace. Close it with `herdr workspace close <id>` first.
- Label the workspace without a repo prefix; the parent row already shows the repo. Read ids from the JSON response. They are opaque strings like `w8Y` and `w8Y:p1`, not ordinals.
