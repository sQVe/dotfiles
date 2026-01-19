# Commit Template

Use this template to create atomic git commits with conventional format and meaningful messages.

## Format

```
<type>(<scope>): <subject>

[optional body]
```

**Type:** feat, fix, docs, style, refactor, test, chore, perf

**Scope:** Optional. Use when scoped to a specific component (e.g., `auth`, `api`, `nvim`).

**Subject:** Imperative mood, no period, under 50 chars. Body only if WHY isn't obvious.

## Examples

**Typical commits (no body needed):**

```
feat: add password reset to reduce user lockout support tickets
fix(auth): resolve upload timeout preventing large file processing
refactor(api): extract validation logic for better maintainability
```

**Complex change requiring explanation:**

```
perf(db): implement connection pooling for database queries

Previous approach created new connections per request causing
memory leaks under high load. Connection pooling reduces memory
usage by 60% and improves response times for concurrent users.
```
