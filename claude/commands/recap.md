---
name: recap
description: Split unstaged work into narrated step commits for review
argument-hint: '[context]'
model: claude-opus-4-6
allowed-tools:
  - Bash
  - Read
  - Edit
  - Glob
  - Grep
---

<objective>
Split unstaged work into small, narrated step commits that explain what changed and why.

Commits are temporary — meant for review in a diff tool, then reset. Each commit stands alone as a clear explanation of one cohesive change.
</objective>

<arguments>
- **context** (optional): Extra context for the splitting. Can be a file path (read it), URL (reference it), or description. Not parsed as a flag — always treated as context.
</arguments>

<process>
1. **Validate prerequisites**
   - Run `git rev-parse --git-dir` — if fails: "Not a git repository"
   - Run `git diff --cached --quiet` — if staged changes exist: "Staged changes detected. Unstage or commit them first."
   - Run `git status --porcelain` — if empty: "No changes to recap"
   - If validation fails: stop with clear message

2. **Read context argument**
   - If argument provided:
     - If it's a file path: read the file and use its content as context
     - Otherwise: treat it as a description or URL reference

3. **Gather changes**
   - Run `git diff` for unstaged modifications
   - Run `git diff --diff-filter=D --name-only` for deleted files
   - Run `git status --porcelain | grep '^??' | cut -c 4-` for untracked files
   - Identify binary files: `git diff --numstat` reports `- -` for binaries
   - For each changed or new text file: read full file content
   - Binary files: note filename only, do not read content
   - Deleted files: note filename only, do not read content
   - If more than 30 files or diff exceeds ~3000 lines: warn user and offer to continue or cancel
   - Build complete picture of all modifications

4. **Auto-detect references**
   - Scan for plan files: `glob .planning/**/*.md`, `glob **/PLAN.md`, `glob **/TODO.md`
   - Check git remote for issue tracker URL: `git remote get-url origin`
   - Check the context argument (if provided) for URLs and issue numbers
   - Scan discovered plan files for URLs, issue numbers, and task references
   - When in doubt, include a reference rather than omit it

5. **Plan the split**
   - Group changes into cohesive logical steps
   - Each step = one logical change (not artificially small, not too large)
   - A step may span multiple files if they form one logical change
   - A single file may be split across steps if it contains independent changes
   - New (untracked) files: always staged whole — do not split across steps
   - Binary files: always staged whole — assign to exactly one step
   - Deleted files: stage the removal with `git add <file>`
   - Assign relevant references to each step
   - Default ordering heuristic (override when the logical narrative demands it):
     1. Configuration and dependency changes (package.json, tsconfig, etc.)
     2. New types, interfaces, or shared utilities
     3. Core logic changes
     4. Consumers of the core changes (components, routes, handlers)
     5. Tests
     6. Documentation and cosmetic changes

6. **Present plan** (OUTPUT GATE)
   - Output the proposed step breakdown as a numbered list
   - For each step: step number, files involved, one-line summary
   - End output with `---` separator
   - **PROHIBITED after separator:**
     - "Let me create/start/begin..."
     - "I'll now..."
     - "Starting with the first..."
     - "Now I will..."
   - Proceed directly to Confirm step

7. **Confirm**
   - IMMEDIATELY use `AskUserQuestion` with options:
     - **Create** — create all step commits
     - **Adjust** — revise the grouping or order
     - **Cancel** — abort

8. **Create step commits sequentially** (fix loop, max 3 attempts per step)
   - For each step:
     - Stage relevant files with `git add <file>`
     - For partial file staging (file split across steps):
       1. Copy the file to a temp location: `cp <file> <file>.recap-tmp`
       2. Edit the file to contain only this step's changes (revert other hunks)
       3. Stage the file: `git add <file>`
       4. Restore the full file: `mv <file>.recap-tmp <file>`
     - Create commit following `<message_format>`
     - If commit fails (pre-commit hook, lint error):
       - Analyze failure output
       - Auto-fix if possible (formatting, lint issues)
       - Re-stage and re-attempt
       - After 3 failures on a step: stop, report which step failed, ask user
     - Verify with `git log --oneline -1`
   - After all steps: run `git log --oneline -N` (where N = step count) to confirm

9. **Report**
   - Output final commit list using `<output_format>`

<anti_patterns>
After presenting findings, NEVER:
- "Let me create/start/begin..."
- "I'll now..."
- "Starting with the first..."
- "Now I will..."
- Announcing intent before user chooses action
</anti_patterns>
</process>

<message_format>
Each step commit uses this format:

```
Step X/N: <concise what>

<why — reasoning behind this change. Explain decisions and trade-offs.
 This is the most valuable part. Write clearly and concisely.>

Note: <optional. Alternatives considered, caveats, tight coupling with
 other steps, or follow-up concerns. Omit if nothing worth flagging.>

Refs:
- <reference 1>
- <reference 2>
```

Rules:
- Subject line: imperative mood, under 72 chars
- Why section: always present, 1-4 sentences
- Note section: omit when there is nothing to flag
- Refs section: include when a reference directly informed or motivated the change, omit freely otherwise
- Do not reference other steps in the message body — each commit stands alone
- Use HEREDOC to pass commit messages to git

Example:

```
Step 3/7: Extract color palette into shared constants

Duplicated hex values across three components had drifted apart.
Centralizing them into a single file prevents inconsistencies
and makes theme changes a one-file edit.

Note: Considered CSS custom properties, but the codebase uses TS
constants throughout. Staying consistent with existing patterns.

Refs:
- .planning/PLAN.md (lines 12-18)
- https://tailwindcss.com/docs/customizing-colors
```
</message_format>

<output_format>

```
✓ Recap complete: {step_count} step commits created

{step_list with short hashes and subjects}
```

---

## ▶ Next Up

**Review commits** — walk through each step in your diff tool

`git log --oneline -{step_count}` — see the full narrative

---

**Also available:**

- `git reset HEAD~{step_count}` — undo step commits, keep changes
- `/commit` — commit properly with conventional format

---

</output_format>

<success_criteria>

- [ ] No staged changes existed before starting
- [ ] All unstaged, untracked, and deleted changes accounted for
- [ ] Binary files identified and staged whole
- [ ] Changes split into cohesive logical steps
- [ ] Each commit message has what, why, and stands alone
- [ ] No cross-step references in commit messages
- [ ] User confirmed before creating commits
- [ ] All step commits created and verified (fix loop if needed)
- [ ] Reset command provided for easy cleanup

</success_criteria>
