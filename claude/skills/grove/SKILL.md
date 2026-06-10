---
name: grove
description: "Create, switch, inspect, and clean up git worktrees via grove. Use when the user wants to work on a branch or PR in a separate worktree, run a command across worktrees, review a PR in isolation, or prune stale worktrees. grove is the interface — do not use raw `git worktree`."
---

# grove — agent skill

grove manages git worktrees. it is the interface for all worktree work — prefer it over raw `git worktree`. the `grove` binary is in PATH and shell integration is already active.

run any grove command from anywhere inside the workspace (any worktree dir). if a command reports `not in a grove workspace`, you are outside one — `cd` into a worktree first, or `grove clone <url>` / `grove init` to make one.

## the cwd rule (read first)

`grove switch` works by `cd`-ing your shell via a shell function. each Bash tool call is a fresh shell, so **`grove switch` never persists across your calls — do not use it to "stay" in a worktree.**

to act inside a specific worktree, use one of:

- `grove exec <worktree> -- <command>` — runs the command in that worktree regardless of cwd. **preferred.**
- `cd <path> && <command>` in a single call — get `<path>` from `grove list --json`.

never assume your cwd is a given worktree between calls.

## discover state

```bash
grove list --json          # machine-readable array — parse this
grove list -v              # human view with paths and upstreams
grove list --filter dirty  # filter by: dirty,ahead,behind,gone,locked
grove status               # current worktree only
```

`grove list --json` returns one object per worktree. fields: `name` (dir), `branch`, `path` (absolute — use this to `cd`), `current` (bool), plus state flags that appear only when set: `dirty`, `upstream` (string) or `no_upstream`, and the filter states (`ahead`/`behind`/`gone`/`locked`). treat absent flags as false.

## core commands

| goal | command |
| --- | --- |
| new branch off main | `grove add --base main feat/x` → creates `./feat-x` |
| existing branch | `grove add feat/x` |
| custom dir name | `grove add feat/x --name x` |
| carry uncommitted files in | `grove add --from <src> feat/x` |
| review a PR | `grove add --pr 123` → creates `./pr-123` |
| run a command in a worktree | `grove exec <wt> -- <cmd>` |
| run across all worktrees | `grove exec --all -- <cmd>` (add `--fail-fast` to stop early) |
| remove one | `grove remove <wt>` |
| prune deleted-upstream worktrees | `grove prune` |

`-s` / `--switch` on `add` only matters interactively (see the cwd rule) — for agent work, create then `grove exec` into it.

## common flows

### start work on a new branch

```bash
grove add --base main feat/thing
grove exec feat-thing -- <setup cmd>   # e.g. install deps
# then operate: grove exec feat-thing -- <cmd>, or cd into its path from `grove list --json`
```

### review a pull request in isolation

```bash
grove add --pr 123                     # checks out the PR branch into ./pr-123
grove exec pr-123 -- <build/test cmd>
grove remove pr-123                    # when done
```

### run the same command everywhere

```bash
grove exec --all -- npm ci
grove exec --all --fail-fast -- go build ./...
```

### clean up

`grove prune` removes worktrees whose upstream branch is gone (the safe bulk cleanup). for a specific one, `grove remove <wt>`. a locked worktree must be `grove unlock`ed first.

## notes

- workspace layout: each repo is a workspace dir holding a `.bare/` (the git data) plus one subdir per worktree — e.g. `fff.nvim/main`, `fff.nvim/feat-x`. `main` is itself a worktree, not special.
- directory name derives from the branch (`feat/x` → `feat-x`) unless `--name` is given. worktrees are created as subdirs of the workspace root.
- team-shared config lives in `.grove.toml` (`grove config init` to scaffold); personal config in global git config. precedence: `grove config list`.
- `grove doctor` diagnoses a broken workspace.
- if you only need to know what exists, `grove list --json` is enough — do not create a worktree to inspect one.
