# Git Workflow

## Branch Strategy

- **main/master**: Production-ready code
- **Branch naming**: `type/description` using [Conventional Commits](https://www.conventionalcommits.org/) types
- **hotfix/**: For urgent production fixes

## Commit Standards

- Follow [Conventional Commits](https://www.conventionalcommits.org/) specification
- **Atomic commits**: One logical change per commit
- **Reference issues when applicable**: Link to tickets, PRs, or documentation when the commit relates to tracked work

## Pre-commit Checklist

1. **Run tests**: Ensure all tests pass
2. **Run linting**: Fix any style or syntax issues
3. **Review changes**: Use `git diff --staged` to review what you're committing
4. **Meaningful message**: Write a clear commit message

**For comprehensive validation before PRs:** Follow @guidelines/completion-workflow.md checklist to ensure quality and completeness.

## Pull Request Process

1. **Update from main**: Rebase or merge latest main into your branch
2. **Self-review**: Review your own changes before requesting review
3. **Clear description**: Explain what changed and why
4. **Link issues**: Reference related tickets or documentation
5. **Request review**: Tag appropriate reviewers

### PR Template

```markdown
## Summary
Brief description of what this PR does and why.

## Changes
- List of key changes
- What was added, modified, or removed

## Testing
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] Manual testing completed

## Related Issues
Fixes #123
Related to #456
```

## Common Commands

```bash
# Start new feature
git checkout -b feature/new-functionality

# Stage and commit changes
git add .
git commit -m "feat: add user authentication"

# Update with latest main
git fetch origin
git rebase origin/main

# Push feature branch
git push -u origin feature/new-functionality
```