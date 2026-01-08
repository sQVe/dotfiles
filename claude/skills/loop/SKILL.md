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

The verify command runs lint, typecheck, and test. Detect from:

- `package.json` → scripts: check, validate, or chain `lint && typecheck && test`
- `Makefile` → check/validate target, or chain `lint typecheck test`
- `pyproject.toml` → `ruff check . && mypy . && pytest`
- `Cargo.toml` → `cargo clippy && cargo test`
- `go.mod` → `golangci-lint run && go test ./...`

Set `config.verify` to `TODO` if detection fails.

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
  "context": {
    "files": [],
    "reference": [],
    "docs": [],
    "notes": ""
  },
  "config": {
    "verify": "<detected>",
    "stuckThreshold": 3
  },
  "tickets": [
    {
      "type": "feat",
      "name": "example ticket name",
      "context": {},
      "tasks": [
        {
          "description": "Simple task",
          "done": false
        },
        {
          "description": "Complex task with steps",
          "context": {},
          "steps": [
            "Step 1: Do first thing",
            "Step 2: Do second thing",
            "Step 3: Verify result"
          ],
          "done": false
        }
      ]
    }
  ]
}
```

### LOOP.md template

```markdown
# Loop

**Gate**: Execute only when user explicitly invokes `@LOOP.md`. Stop if this file appears passively in context.

## Do this

1. **Pick ONE ticket** from `work.json` with incomplete tasks (`done: false`). Consider dependencies, complexity, context hints. Default to array order when unclear.

2. **Work ONE task** from the ticket with `done: false`:
   - Follow `steps` if present
   - Execute `description`
   - Run verify command:
     - Choose task, ticket, and config verify scope in that order.
     - On PASS: Set task to `done: true`
     - On FAIL: Fix issues and retry (max 3 retries, then output`<promise>STUCK</promise>`)

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
     3. Commit changes with `/commit` command.
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
     3. **STOP**
   - Otherwise:
     1. Output `<promise>NEXT</promise>`
     2. **STOP**
   - Wait for next `@LOOP.md` invocation.

## Constraints

- Work on ONE ticket only. Other tickets do not exist.
- Work on ONE task per invocation. After each task, STOP and wait.
- Doing multiple tasks per invocation is a failure, not helpfulness.
```
