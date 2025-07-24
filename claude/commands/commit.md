# Commit Command

Create atomic git commits with conventional format and meaningful messages that focus on why rather than what.

## Usage
```
/commit [commit-message]
```

## Instructions
You are helping create clean, atomic git commits with meaningful messages. Follow these steps:

1. **Prepare changes** by reviewing current state and grouping related modifications into logical units

2. **Create conventional commits** using the guidelines from `claude/templates/commit-template.md`:
   - Use conventional commit format: `type: description`
   - Focus on "why" rather than "what" in commit messages
   - Ensure each commit represents one logical, atomic change
   - Stage appropriate files for each commit

3. **Verify commit history** ensuring clean progression and no uncommitted changes

## Examples
```bash
# Create commits for current changes
/commit

# Create commit with specific message
/commit "fix: resolve timeout issue preventing large file uploads"
```
