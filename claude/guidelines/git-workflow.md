# Git Workflow

## Branch Strategy

- **main/master**: Production-ready code
- **Branch naming**: `type/description` using [Conventional Commits](https://www.conventionalcommits.org/) types
- **hotfix/**: For urgent production fixes

## Commit Standards

- Follow [Conventional Commits](https://www.conventionalcommits.org/) specification
- **Atomic commits**: One logical change per commit
- **Concise messages**: Focus on **why**, not **what** - let the diff show file changes
- **72-character limit**: Keep first line under 72 characters
- **No file listings**: Avoid listing changed files in commit messages
- **Reference issues when applicable**: Link to tickets, PRs, or documentation when the commit relates to tracked work

### Commit Message Guidelines

**Good examples:**
```
feat: add user authentication
fix: resolve memory leak in background sync
refactor: simplify error handling logic
```

**Avoid verbose descriptions:**
```
❌ feat: add comprehensive user authentication system

- Add UserAuth.js with login/logout functionality
- Update config/auth.js with JWT token handling
- Create auth/middleware.js for route protection
- Add tests in test/auth.spec.js for coverage
```

**Instead, write:**
```
✅ feat: add user authentication with JWT tokens
```

## Pre-commit Checklist

1. **Run tests**: Ensure all tests pass
2. **Run linting**: Fix any style or syntax issues
3. **Review changes**: Use `git diff --staged` to review what you're committing
4. **Meaningful message**: Write a clear commit message

## Pull Request Process

1. **Update from main**: Rebase or merge latest main into your branch
2. **Self-review**: Review your own changes before requesting review
3. **Clear description**: Explain what changed and why
4. **Link issues**: Reference related tickets or documentation
5. **Request review**: Tag appropriate reviewers

### PR Template

```markdown
Brief description of what this PR does and why.

#### Changes

- List of key changes
- What was added, modified, or removed

#### Testing

- [ ] Tests added/updated
- [ ] All tests pass
- [ ] Manual testing completed

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
