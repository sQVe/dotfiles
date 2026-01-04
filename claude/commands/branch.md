# Branch Command

Generate and create a git branch name from session context, Linear tickets, and current changes.

## Usage

```
/branch [branch-name]
```

## Instructions

You are helping create a meaningful branch name based on context.

1. **Gather context**
   - Review the current conversation to understand the task being worked on
   - Check git status and diff for insight into what's changing
   - Look for Linear ticket references in the session
   - If no ticket found, use Linear MCP to check for assigned/in-progress tickets that match the work

2. **Generate branch name**
   - **With Linear ticket (preferred)**: `<team>-<number>-<description>`
     - Use team identifier and issue number from Linear (e.g., `LIN-156`)
     - Generate a concise description from session context (not the issue title)
     - Keep description short and focused on the actual work
   - **Without Linear ticket**: `<type>/<description>`
     - Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`
     - Use kebab-case, keep under 50 characters

3. **Confirm and create**
   - Present the suggested branch name with brief rationale
   - Ask "Create this branch?" and wait for confirmation
   - Run `git checkout -b <branch-name>`
   - Verify with `git branch --show-current`

## Examples

```bash
# Generate branch from current session context
/branch

# Override with specific name
/branch "feat/LIN-42-user-auth"
```

### Example Output

```
Found Linear ticket LIN-156

Suggested branch: lin-156-dark-mode

Create this branch?
```
