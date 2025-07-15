# Implementation workflow

*During implementation: Tracking and communication*

### TodoWrite usage for complex tasks

**Essential for multi-step work** - track progress with specific task items, clear status updates, and completion checkmarks.

```bash
# Use TodoWrite to plan and track complex features
TodoWrite
```

**When to use TodoWrite:**
- Features requiring 3+ distinct steps.
- Non-trivial implementations with multiple components.
- Debugging complex issues with multiple potential causes.
- Refactoring that affects multiple files or systems.

**How to structure tasks:**
- Break down into specific, actionable items.
- Mark tasks as in_progress before starting work.
- Complete tasks immediately after finishing - don't batch.
- Add follow-up tasks as you discover them.
- Create implementation journal for complex features during planning.

### Implementation memory creation

**For complex implementations, create implementation journals:**

```markdown
# Feature: [Feature Name]
**Started:** YYYY-MM-DD | **Status:** In Progress | **Issue:** #123

## Context and requirements
- Why this was needed
- Key constraints and requirements
- Success criteria

## Journey log
### YYYY-MM-DD HH:MM - Phase Name
- Decisions made
- Attempts tried
- Results and discoveries

## Key decisions
- **Decision Type:** Choice made and rationale
- **Alternatives Considered:** What was rejected and why

## Gotchas and lessons
- Unexpected issues encountered
- Performance characteristics discovered
- Security considerations that emerged
```

**Store implementation journals in:** `.claude/memory/features/[feature-name]-YYYY-MM.md`

**Testing integration:** Follow @guidelines/testing-workflow.md for TDD practices and test organization throughout implementation. Test as you build, not after completion.

