# Switch worktree

Switch to a Grove worktree and change working directory.

## Usage

```
/switch [worktree]
```

## Instructions

### With argument

If `$ARGUMENTS` is provided, attempt to switch:

```bash
cd "$(grove switch $ARGUMENTS)"
```

If successful, confirm with `pwd`.

If it fails, continue to the interactive flow below.

### Interactive flow (no argument or switch failed)

1. List available worktrees:

```bash
grove list
```

2. Use AskUserQuestion to ask the user which worktree they want to switch to. Show the list in the question.

3. Match the user's response against the worktree list. Find the worktree whose name contains the user's input (case-insensitive partial match).

4. Switch to the matched worktree:

```bash
cd "$(grove switch <matched-worktree>)"
```

5. Confirm with `pwd`.

If no match found, tell the user and show the list again.
