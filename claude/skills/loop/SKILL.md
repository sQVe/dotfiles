---
name: loop
description: Use when starting ticket-driven work to scaffold work.json5 and LOOP.md templates
---

# Ticket workflow scaffolding

Creates `work.json5` and `LOOP.md` templates in the current directory.

## Execute

1. Check for existing files:
   ```bash
   ls work.json5 LOOP.md 2> /dev/null
   ```
2. If either file exists, warn and abort
3. Read templates from `~/.claude/skills/loop/templates/`
4. Detect `config.verify` from project files
5. Detect `guidance.docs` (guideline files)
6. Create both files with detected values
7. Output customization instructions

## Templates

- `~/.claude/skills/loop/templates/work.json5`
- `~/.claude/skills/loop/templates/LOOP.md`

## Detecting config.verify

Detect available verification commands. Each is optional - set to `null` if unavailable.

| Type      | Look for                                                                                 |
| --------- | ---------------------------------------------------------------------------------------- |
| lint      | `package.json` scripts.lint, ruff, golangci-lint, clippy                                 |
| manual    | Not auto-detected. User specifies array of manual verification steps (browser tests etc) |
| test      | `package.json` scripts.test, pytest, go test, cargo test                                 |
| typecheck | `package.json` scripts.typecheck/tsc, mypy, pyright, go build, cargo check               |

Prefer project-specific scripts over global tools.

## Detecting guidance.docs

Look for guideline files in project root and `.claude/` directory:

- `.claude/CLAUDE.md`
- `CLAUDE.md`
- `CONTRIBUTING.md`
- `CONVENTIONS.md`
- `STYLE.md`

Add any that exist to `guidance.docs` array.
