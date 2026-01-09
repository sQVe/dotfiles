# Commit Command

Create atomic git commits with conventional format and meaningful messages.

## Usage

```
/commit [--no-confirm] [commit-message]
```

## Instructions

1. **Prepare changes**
   - Review current git state with `git status` and `git diff`
   - Group related modifications into atomic units

2. **Create commits**
   - Use [commit template](/home/sqve/.dotfiles/claude/templates/commit-template.md) for format
   - Use conventional commit format (feat:, fix:, docs:, etc.)
   - Messages explain why, not what
   - Skip commit bodies unless reasoning is non-obvious
   - Stage only files relevant to each commit

3. **Confirm before committing** (skip if `--no-confirm`)
   - Show staged files and proposed commit message
   - Ask "Create this commit?" and wait for confirmation

4. **Verify commit history**
   - Run `git log --oneline -5` to confirm clean progression
   - Check `git status` shows no uncommitted changes

## Examples

```bash
# Create commits for current changes
/commit

# Create commit with specific message
/commit "fix: resolve timeout issue in file uploads"
```
