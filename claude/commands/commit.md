# Commit Command

Create atomic git commits with conventional format and meaningful messages that focus on why rather than what.

## Usage

```
/commit [commit-message]
```

## Instructions

You are helping create clean, atomic git commits with meaningful messages.

1. **Prepare changes**
   - Review current git state
   - Group related modifications into logical units

2. **Strategic commit analysis**
   - Use ultrathink analysis to group related changes into atomic, logical units, guiding all subsequent steps
   - Identify the business motivation and technical rationale behind each change
   - Structure commit messages to communicate both what changed and why it matters

3. **Create commits**
   - Use conventional commit format
   - Commit description should capture both "what" and "why"
   - Commit body should be used for complex changes or non-obvious reasons
   - Commits should be atomic and represent one logical change
   - Stage appropriate files for each commit
   - Use [commit template](../templates/commit-template.md) for commit format.

4. **Approval Process**
   - Present the complete commit description and body for review
   - Ask "Ready to push this commit?" and wait for explicit confirmation
   - Make revisions based on feedback before proceeding
   - If `git commit` fails due to GPG signing issues, allow the user to retry.

5. **Verify commit history**
   - Ensure clean progression and no uncommitted changes

## Examples

```bash
# Create commits for current changes
/commit

# Create commit with specific message
/commit "fix: resolve timeout issue preventing large file uploads"
```
