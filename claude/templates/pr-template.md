# Pull Request Template

Use this template when creating pull requests to ensure consistent, clear documentation.

## Format

```markdown
[Brief description of what this PR accomplishes]

#### Changes

- [Describe key changes made]
- [Include technical implementation details]
- [Highlight any architectural or design decisions]

#### Test plan
<!-- Consider: happy path, edge cases, integration points, regression risks -->

- [ ] [Specific test item]
- [ ] [Specific test item]

[Optional: Add any additional context, screenshots, or notes]

---

Fixes #[issue-number]
Related to #[issue-number]
```

## Example

```markdown
Added JWT-based authentication system for secure user access.

#### Changes

- Implemented JWT token generation and validation
- Added login/logout endpoints with session management
- Created authentication middleware for protected routes

#### Test plan

- [ ] Navigate to /login and verify login form renders
- [ ] Test login with valid credentials - should redirect to dashboard
- [ ] Test login with invalid credentials - should show error message
- [ ] Verify `/api/auth/login` returns JWT on success
- [ ] Verify protected routes redirect to login when not authenticated
- [ ] Test logout clears session and redirects to login

Fixes #123
Related to #456
```

## Guidelines

- **Changes**: Focus on "what" was implemented with technical details
- **Test plan**: Specific, actionable items (see coverage prompt in template)
- **Issues**: Link related issues with "Fixes #" or "Related to #"

### Test plan format

Test items are auto-executed when possible. Use these patterns for automation:

**Automatable items** (will be executed and checked off):

- Commands: "Run `npm test`", "Execute `make build`"
- URLs: "Navigate to `/dashboard`", "Verify `/api/health` returns 200"
- Build checks: "Verify build passes", "Check for type errors"

**Manual items** (left unchecked for reviewers):

- Subjective: "Verify UI looks correct"
- Complex flows: "Complete full checkout flow"
- External: "Confirm email is received"

**Never include** (not actionable before PR):

- CI status: "CI passes", "All checks green"
- Review gates: "Approved by reviewer", "Code review complete"
- Merge status: "No merge conflicts", "Branch up to date"

These happen automatically after PR creation. Don't clutter the test plan with them.
