# Scaffold loop-machine files

Creates `_loop/` directory with `WORKFLOW.md`, `loop.log`, and `work.json5`.

## Execute

1. Check for existing directory:
   ```bash
   ls -d _loop 2> /dev/null
   ```
2. If `_loop/` exists, warn and abort
3. Read templates from `~/.claude/templates/loop-machine/`
4. Detect `config.verify` from project files
5. Detect `guidance.docs` (guideline files)
6. Create `_loop/` directory with all three files
7. Output customization instructions

## Detecting config.verify

Detect available verification commands. Each is optional — set to `null` if unavailable.

| Type      | Look for                                                                   |
| --------- | -------------------------------------------------------------------------- |
| lint      | `package.json` scripts.lint, ruff, golangci-lint, clippy                   |
| typecheck | `package.json` scripts.typecheck/tsc, mypy, pyright, go build, cargo check |
| build     | `package.json` scripts.build, make, cargo build, go build                  |
| test      | `package.json` scripts.test, pytest, go test, cargo test                   |
| human     | Not auto-detected. User specifies subjective checks requiring judgment     |

Prefer project scripts (faster, more reliable) over global tools.

## Detecting guidance.docs

Find guideline files from repo root:

```bash
fd -t f "^(CLAUDE|CONTRIBUTING|CONVENTIONS|STYLE)\.md$" "$(git rev-parse --show-toplevel)"
```

This catches files at any depth, including inside `.claude/` directories.

**Prioritization:** Files closer to the working directory take precedence. For monorepos, include files along the ancestor path from `$PWD` to repo root, not sibling packages.

Add discovered files to `guidance.docs` array.
