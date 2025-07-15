# Critical requirements

### Research and understanding

- **Always search documentation before writing code**: Use `mcp__ref__ref_search_documentation` to find current best practices and patterns.
- **Ask clarifying questions about requirements**: Never assume requirements. Ask about user experience, edge cases, performance constraints, and security implications.
- **Understand existing codebase patterns**: Analyze current code structure, conventions, and libraries before making changes.

### Quality and safety

- **Always run validation before completion**: Run lint, typecheck, and tests. Never say "done" without verification.
- **Handle all errors explicitly**: No silent failures. Every error case must be addressed with proper logging and user feedback.
- **Follow security standards**: See `@guidelines/security-standards.md` for comprehensive security requirements.

### Communication and tracking

- **Use TodoWrite tool for complex tasks**: Track multi-step work systematically. Break down complex features into manageable pieces.
- **Provide honest technical assessment**: See `@guidelines/technical-assessment.md` for comprehensive evaluation practices.
- **Preserve technical context in implementation memory**: Don't delete valuable information. Keep rationale for decisions, performance notes, and cross-references in implementation journals.

### Code clarity

- **Write clear, obvious code**: No clever tricks. Code should be maintainable by someone who doesn't know the original context.
- **Make incremental, testable changes**: Small, focused commits that can be easily reviewed and debugged.
- **Follow existing code patterns**: Mimic established conventions for naming, organization, and architecture.
