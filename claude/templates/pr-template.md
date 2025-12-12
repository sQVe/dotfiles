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

- [ ] [Describe manual testing steps]
- [ ] [Include specific scenarios to verify]
- [ ] [Add steps for edge cases or error conditions]
- [ ] [Verify existing functionality still works]

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

- [ ] Navigate to /login and verify login form renders correctly
- [ ] Test login with valid credentials - should redirect to dashboard
- [ ] Test login with invalid credentials - should show error message
- [ ] Verify protected routes redirect to login when not authenticated
- [ ] Test logout functionality clears session and redirects to login
- [ ] Check that JWT tokens expire after configured time

Fixes #123
Related to #456
```

## Guidelines

- **Changes**: Focus on "what" was implemented with technical details
- **Test plan**: Provide actionable testing steps with checkboxes
- **Issues**: Link related issues with "Fixes #" or "Related to #"
