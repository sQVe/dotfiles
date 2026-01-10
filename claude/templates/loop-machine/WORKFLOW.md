# Workflow

## State Machine

```
BRANCH_SETUP → PICK_TICKET → WORK_TASK → CHECKPOINT
                                              │
                              ┌───────────────┴───────────────┐
                              ▼                               ▼
                         STOP (wait)                    TICKET_REVIEW
                                                              │
                                              ┌───────────────┴───────────────┐
                                              ▼                               ▼
                                            STOP                         FINAL_REVIEW
                                                                              │
                                                                              ▼
                                                                            DONE
```

---

## States

### BRANCH_SETUP

**Skip if:** No `prs` array in work.json5

1. Find first PR group with incomplete tickets (any task `done: false`)
2. If none found → `<promise>DONE</promise>` STOP
3. Get group's `branch` value
4. If current branch differs → switch (see: Branch Switching)
5. Note PR group's tickets for PICK_TICKET

→ PICK_TICKET

### PICK_TICKET

**Source:** PR group's tickets (if `prs` exists), else all tickets

1. Pick ONE ticket with incomplete tasks (`done: false`)
2. Priority: dependencies → complexity → context hints → array order

→ WORK_TASK

### WORK_TASK

1. Pick ONE task with `done: false`
2. Follow `steps` if present, else execute `description`
3. Run verification (see: Verification Cascade)
4. Outcome:

| Result                    | Action                                     |
| ------------------------- | ------------------------------------------ |
| PASS                      | Log TASK, set `done: true` → CHECKPOINT    |
| FAIL (≤ `stuckThreshold`) | Log FAIL, AI attempts fix, retry           |
| FAIL (> `stuckThreshold`) | Log STUCK, `<promise>STUCK</promise>` STOP |

### CHECKPOINT

| Condition         | Next State                      |
| ----------------- | ------------------------------- |
| Ticket incomplete | STOP (wait for next invocation) |
| Ticket complete   | TICKET_REVIEW                   |

### TICKET_REVIEW

1. Spawn 3 parallel review agents (see: Ticket review prompt)
2. On FAIL: AI fixes, retry up to `stuckThreshold`, else `<promise>STUCK</promise>` STOP
3. Log REVIEW
4. Commit (see: Commit with stash)
5. If PR group complete → `/pr --no-confirm` (title from group's `title`)
6. If ALL tickets complete → FINAL_REVIEW

→ STOP (if not all complete)

### FINAL_REVIEW

1. Spawn 3 parallel review agents (see: Final review prompt)
2. On FAIL: AI fixes, retry up to `stuckThreshold`, else `<promise>STUCK</promise>` STOP
3. Log FINAL

→ `<promise>DONE</promise>` STOP

---

## Procedures

### Branch switching

```bash
current=$(git branch --show-current)
if [ "$current" != "$target" ]; then
  # .git as file (not dir) = git-worktree setup pointing to bare repo
  if [ -f .git ] && grep -q 'gitdir:' .git; then
    grove add --base main "$target" 2> /dev/null || true
    cd "$(git worktree list --porcelain | awk -v b="$target" '$1=="worktree" {wt=$2} $1=="branch" && $2~b {print wt}')"
  else
    git checkout "$target" 2> /dev/null || git checkout -b "$target"
  fi
fi
```

### Verification cascade

1. Merge priority: task > ticket > config (closest non-null wins per property)
2. Run in order: lint → typecheck → build → test → human
3. Stop on first failure
4. No `--filter`, `--only`, or path targeting
5. If `human` set: present steps, await user confirmation

### Commit with stash

```bash
git stash push --message "loop-files" -- WORKFLOW.md loop.log work.json5 2> /dev/null || true
/commit --no-confirm
git stash list | grep --max-count=1 "loop-files" | cut --delimiter=: --fields=1 | xargs --no-run-if-empty git stash pop
```

---

## Services

Services are background processes (dev servers, etc.) needed for browser/terminal verification.

### Definition

Top-level `services` object defines available services:

- String: shell command (e.g., `dev: 'pnpm dev'`)
- Object: `{ command, cwd }` for monorepos

### Activation

`verify.services` array declares which services are needed before browser/terminal checks run.

### Lifecycle (agent-managed)

1. **Start:** When verify.services needs it and not running
2. **Restart:** When cwd changed OR after dependency-install commands (pnpm install, npm install, pip install, cargo build, etc.)
3. **Keep running:** Between tasks when state unchanged (avoid 30s+ restart overhead)
4. **Stop:** At session end

### Ready Detection

Agent watches stdout for startup patterns, parses dynamic port for browser checks.

---

## Constraints

- ONE ticket per session. Other tickets do not exist.
- ONE task per invocation. After each task, STOP.
- Multiple tasks per invocation = failure.


## Review prompts

### Ticket review prompt

> Review code changes for the completed ticket against `work.json5`.
>
> Criteria:
>
> 1. Tasks match changes (each task has corresponding code)
> 2. No bugs introduced
> 3. Follows established patterns
> 4. No over-engineering
> 5. No scope creep (nothing beyond what tasks specified)
>
> Output: PASS or FAIL with list of issues.

### Final review prompt

> Review all changes in this branch against `work.json5`.
>
> Criteria:
>
> 1. Cross-ticket integration (changes work together)
> 2. No regressions (later tickets didn't break earlier work)
> 3. Consistent patterns across all tickets
> 4. No duplicate or conflicting code between tickets
> 5. Complete solution (nothing missing from requirements)
>
> Output: PASS or FAIL with list of issues.

---

## Log format

`loop.log` captures progress. Add `## <ticket-name>` section header, then entries:

| Type   | When              | Format                                      |
| ------ | ----------------- | ------------------------------------------- |
| TASK   | Verification PASS | `[HH:MM] TASK Desc - outcome`               |
| FAIL   | Verification FAIL | `[HH:MM] FAIL Desc - error (N/threshold)`   |
| REVIEW | Ticket review     | `[HH:MM] REVIEW PASS` or `FAIL (N): fix`    |
| FINAL  | Final review      | `[HH:MM] FINAL PASS` or `FAIL (N): fix`     |
| STUCK  | Hit retry limit   | `[HH:MM] STUCK Desc - context`              |

**Example:**

```
## add retry logic
[14:32] TASK Implement exponential backoff - added retry util with 2^n delay
[14:45] FAIL Add max retry config - Cannot read 'id' of undefined (1/3)
[14:52] TASK Add max retry config - config.maxRetries controls limit
[15:01] REVIEW PASS
```

---

## STOP semantics

| Signal                     | Meaning                                            |
| -------------------------- | -------------------------------------------------- |
| STOP                       | Halt execution, wait for next invocation           |
| `<promise>DONE</promise>`  | All work complete, no more invocations needed      |
| `<promise>STUCK</promise>` | Unrecoverable failure, requires human intervention |
