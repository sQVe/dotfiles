# Loop

## Do this

1. **Pick ONE ticket** from `work.json5` with incomplete tasks (`done: false`). Consider dependencies, complexity, context hints. Default to array order when unclear.

2. **Work ONE task** from the ticket with `done: false`:
   - Follow `steps` if present
   - Execute `description`
   - Run verification (lint → typecheck → test → manual):
     - Merge scopes: task overrides ticket overrides config (closest non-null wins per property)
     - Run each non-null command in order, stop on first failure
     - Always run full commands as configured - no `--filter`, `--only`, or path targeting
     - If `manual` is set, present the steps to user and wait for confirmation that all passed
     - On PASS: Set task to `done: true`
     - On FAIL: Fix issues and retry (max 3 retries, then output `<promise>STUCK</promise>`)

3. **CHECKPOINT** (MANDATORY after every task):
   - If ticket complete (all tasks done):
     1. Spawn 3 parallel code review agents with:
        > Review the unstaged changes for the completed ticket against `work.json5`.
        > Criteria:
        >
        > 1. Tasks match changes (each task has corresponding code),
        > 2. No bugs introduced,
        > 3. Follows established patterns,
        > 4. No over-engineering,
        > 5. No scope creep (nothing beyond what tasks specified).
        >
        > Output: PASS or FAIL with list of issues.
     2. On FAIL: Fix issues and retry (max 3 retries, then output `<promise>STUCK</promise>`)
     3. Stash loop files, commit, restore:
        - `git stash push --message "loop-files" -- work.json5 LOOP.md 2>/dev/null || true`
        - Run `/commit` command
        - `git stash list | grep --max-count=1 "loop-files" | cut --delimiter=: --fields=1 | xargs --no-run-if-empty git stash pop`
     4. If `prs` array exists:
        - Find the PR group whose `tickets` contains the completed ticket name
        - Check if every ticket in that group has all tasks `done: true`
        - If yes: Run `/pr` (title from PR group's `title` field)
     5. **STOP**
   - If ALL tickets complete (all tasks `done: true`):
     1. Spawn 3 parallel code review agents with:
        > Review all changes in this branch against `work.json5`.
        > Criteria:
        >
        > 1. Cross-ticket integration (changes work together),
        > 2. No regressions (later tickets didn't break earlier work),
        > 3. Consistent patterns across all tickets,
        > 4. No duplicate or conflicting code between tickets,
        > 5. Complete solution (nothing missing from requirements).
        >
        > Output: PASS or FAIL with list of issues.
     2. On FAIL: Fix issues and retry (max 3 retries, then output `<promise>STUCK</promise>`)
     3. Output `<promise>DONE</promise>`
     4. **STOP**
   - Otherwise:
     1. **STOP**

## Constraints

- Work on ONE ticket only. Other tickets do not exist.
- Work on ONE task per invocation. After each task, STOP and wait.
- Doing multiple tasks per invocation is a failure, not helpfulness.
