# Switch Command

Switch to a Grove worktree and change working directory.

## Usage

```
/switch [worktree]
```

## Instructions

1. **Switch with argument**
   - If `$ARGUMENTS` is provided, run `cd "$(grove switch $ARGUMENTS)"`
   - If successful, confirm with `pwd`
   - If it fails, continue to interactive flow

2. **Interactive selection**
   - List available worktrees with `grove list`
   - Use AskUserQuestion to ask which worktree to switch to
   - Match user's response (case-insensitive partial match)
   - Run `cd "$(grove switch <matched-worktree>)"`
   - Confirm with `pwd`

3. **Handle failures**
   - If no match found, show the list again and ask for clarification

## Examples

```bash
# Switch interactively
/switch

# Switch to specific worktree
/switch feature-auth
```
