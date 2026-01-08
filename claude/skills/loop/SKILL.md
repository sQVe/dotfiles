---
name: loop
description: Use when starting ticket-driven work to scaffold work.json and LOOP.md templates
---

# Ticket workflow scaffolding

Creates `work.json` and `LOOP.md` templates in the current directory.

## Execute

1. Check for existing files:
   ```bash
   ls work.json LOOP.md 2> /dev/null
   ```
2. If either file exists, warn and abort
3. Detect `config.verify` from project files
4. Detect `context.docs` (guideline files)
5. Create both files from templates
6. Output customization instructions

### Detecting config.verify

Detect available verification commands. Each is optional - set to `null` if unavailable.

| Type      | Look for                                                                            |
| --------- | ----------------------------------------------------------------------------------- |
| lint      | `package.json` scripts.lint, ruff, golangci-lint, clippy                            |
| state     | Not auto-detected. User specifies manually for checks requiring human confirmation. |
| test      | `package.json` scripts.test, pytest, go test, cargo test                            |
| typecheck | `package.json` scripts.typecheck/tsc, mypy, pyright, go build, cargo check          |

Prefer project-specific scripts over global tools.

### Detecting context.docs

Look for guideline files in project root and `.claude/` directory:

- `.claude/CLAUDE.md`
- `CLAUDE.md`
- `CONTRIBUTING.md`
- `CONVENTIONS.md`
- `STYLE.md`

Add any that exist to `context.docs` array.

### work.json template

```json
{
  "$schema": "/home/sqve/.claude/skills/loop/schema.json",
  "_note": "DATA ONLY. Process with @LOOP.md",
  "config": {
    "stuckThreshold": 3,
    "verify": {
      "lint": "<detected or null>",
      "state": null,
      "test": "<detected or null>",
      "typecheck": "<detected or null>"
    }
  },
  "context": {
    "docs": [],
    "files": [],
    "notes": "",
    "reference": []
  },
  "tickets": [
    {
      "context": {},
      "name": "example ticket name",
      "tasks": [
        {
          "description": "Simple task",
          "done": false
        },
        {
          "context": {},
          "description": "Complex task with steps",
          "done": false,
          "steps": [
            "Step 1: Do first thing",
            "Step 2: Do second thing",
            "Step 3: Verify result"
          ]
        }
      ],
      "type": "feat"
    }
  ]
}
```

### LOOP.md template

```markdown
# Loop

## Do this

1. **Pick ONE ticket** from `work.json` with incomplete tasks (`done: false`). Consider dependencies, complexity, context hints. Default to array order when unclear.

2. **Work ONE task** from the ticket with `done: false`:
   - Follow `steps` if present
   - Execute `description`
   - Run verification (lint → typecheck → test → state):
     - Merge scopes: task overrides ticket overrides config (closest non-null wins per property)
     - Run each non-null command in order, stop on first failure
     - Always run full commands as configured - no `--filter`, `--only`, or path targeting
     - If `state` is set, prompt user to confirm the described state after commands pass
     - On PASS: Set task to `done: true`
     - On FAIL: Fix issues and retry (max 3 retries, then output `<promise>STUCK</promise>`)

3. **CHECKPOINT** (MANDATORY after every task):
   - If ticket complete (all tasks done):
     1. Spawn 3 parallel code review agents with:
        > Review the unstaged changes for the completed ticket against `work.json`.
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
        - `git stash push --message "loop-files" -- work.json LOOP.md 2>/dev/null || true`
        - Run `/commit` command
        - `git stash list | grep --max-count=1 "loop-files" | cut --delimiter=: --fields=1 | xargs --no-run-if-empty git stash pop`
     4. **STOP**
   - If ALL tickets complete (all tasks `done: true`):
     1. Spawn 3 parallel code review agents with:
        > Review all changes in this branch against `work.json`.
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
```
