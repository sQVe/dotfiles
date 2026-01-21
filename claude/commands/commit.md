---
name: commit
description: Create atomic git commits with conventional format
argument-hint: '[--no-confirm] [commit-message]'
model: claude-sonnet-4-5-20250929
allowed-tools:
  - Bash
  - Read
---

<objective>
Create atomic git commits with conventional format and meaningful messages.

Group related changes into atomic units. Explain why, not what.
</objective>

<arguments>
- **--no-confirm** (optional): Skip confirmation prompt
- **commit-message** (optional): Explicit commit message to use
</arguments>

<context_injection>
@/home/sqve/.dotfiles/claude/templates/commit-template.md
</context_injection>

<process>
1. **Validate prerequisites**
   - Run `git rev-parse --git-dir` — if fails: "Not a git repository"
   - Run `git status --porcelain` — if empty: "No changes to commit"
   - If validation fails: stop with clear message

2. **Analyze changes**
   - Run `git status` and `git diff`
   - Group related modifications into atomic units
   - Each commit should represent one logical change

3. **Generate commit message**
   - Use conventional commit format per injected template
   - Messages explain WHY, not what
   - Skip body unless reasoning is non-obvious

4. **Present** (OUTPUT GATE)
   - Output staged files and proposed commit message
   - End output with `---` separator
   - **PROHIBITED after separator:**
     - "Let me...", "I'll...", "Now I will..."
     - "Starting with...", "First I'll..."
     - Any action-announcing language
   - Proceed directly to Confirm step

5. **Confirm** (skip if `--no-confirm`)
   - IMMEDIATELY use `AskUserQuestion` with options:
     - **Commit** — create the commit
     - **Edit** — revise the message
     - **Cancel** — abort

6. **Create and verify** (fix loop, max 3 attempts)
   - Stage only files relevant to each commit
   - Create commit
   - If commit fails (pre-commit hook, lint error):
     - Analyze failure output
     - Auto-fix if possible (formatting, lint issues)
     - Re-attempt commit
     - After 3 failures: report issues, ask user to fix manually
   - Run `git log --oneline -5` to confirm
   - Check `git status` shows expected state

7. **Report and continue**
   - Output commit hash and summary
   - If more uncommitted changes remain, note them

<anti_patterns>
After presenting findings, NEVER:
- "Let me create/start/begin..."
- "I'll now..."
- "Starting with the first..."
- "Now I will..."
- Announcing intent before user chooses action
</anti_patterns>
</process>

<output_format>

```
✓ Commit created: {short_hash}

{type}({scope}): {subject}

Files: {file_count} changed
```

---

## ▶ Next Up

**Review changes** — verify commit before pushing

`git show --stat` — inspect the commit

---

**Also available:**

- `/pr` — create pull request
- `git push` — push to remote

---

</output_format>

<success_criteria>

- [ ] Changes grouped into atomic units
- [ ] Commit message follows conventional format
- [ ] User confirmed (unless --no-confirm)
- [ ] Commit created (with fix loop if needed)
- [ ] Commit verified with git log

</success_criteria>
