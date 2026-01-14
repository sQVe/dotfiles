---
name: commit
description: Create atomic git commits with conventional format
argument-hint: '[--no-confirm] [commit-message]'
allowed-tools:
  - Bash
  - Read
---

<objective>
Create atomic git commits with conventional format and meaningful messages.

Groups related changes into atomic units. Messages explain why, not what.
</objective>

<arguments>
- **--no-confirm** (optional): Skip confirmation prompt
- **commit-message** (optional): Explicit commit message to use
</arguments>

<context_injection>
@/home/sqve/.dotfiles/claude/templates/commit-template.md
</context_injection>

<process>
1. **Analyze changes**
   - Run `git status` and `git diff`
   - Group related modifications into atomic units
   - Each commit should represent one logical change

2. **Generate commit message**
   - Use conventional commit format per `<commit_format>`
   - Messages explain WHY, not what
   - Skip body unless reasoning is non-obvious

3. **Confirm** (skip if `--no-confirm`)
   - Show staged files and proposed message
   - Ask "Create this commit?" and wait for confirmation

4. **Create and verify**
   - Stage only files relevant to each commit
   - Create commit
   - Run `git log --oneline -5` to confirm
   - Check `git status` shows clean state
</process>

<commit_format>

```
<type>(<scope>): <subject>

[optional body]
```

**Types:** feat, fix, docs, style, refactor, test, chore, perf
**Scope:** Component or area affected (optional)
**Subject:** Imperative mood, no period, under 50 chars
**Body:** Only if WHY isn't obvious from subject
</commit_format>

<success_criteria>

- [ ] Changes grouped into atomic units
- [ ] Commit message follows conventional format
- [ ] User confirmed (unless --no-confirm)
- [ ] Commit created and verified

</success_criteria>
