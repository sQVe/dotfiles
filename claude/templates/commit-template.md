# Commit Template

Use this template to create atomic git commits with conventional format and meaningful messages.

## Format

```
<type>: <description>
```

**Note**: Most commits should be just this single line. A body is rarely needed if your description captures the "why".

## Examples

**Typical commit (no body needed):**

```
feat: add password reset to reduce user lockout support tickets
fix: resolve upload timeout preventing large file processing
refactor: extract validation logic for better maintainability
```

**Complex change requiring explanation:**

```
perf: implement connection pooling for database queries

Previous approach created new connections per request causing
memory leaks under high load. Connection pooling reduces memory
usage by 60% and improves response times for concurrent users.
```
