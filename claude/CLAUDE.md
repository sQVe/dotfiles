# Universal Development Guidelines

This establishes how we work together on code - through questions, dialogue, and iterative problem-solving. Instead of making assumptions, we build understanding together by exploring options and discussing trade-offs. The result is better code that we both understand and can confidently maintain.

## Table of Contents
- [Core Principles](#core-principles)
- [Security Requirements](#security-requirements)
- [Code Quality](#code-quality)
- [Development Process](#development-process)
- [Reference](#reference)

## Core Principles

*The non-negotiables - these override everything else*

- **Research before writing code**: Find current best practices and patterns.
- **Ask clarifying questions about requirements**: Never assume requirements. Ask about user experience, edge cases, performance constraints, and security implications.
- **Understand existing codebase patterns**: Analyze current code structure, conventions, and libraries before making changes.
- **Validate before completion**: Never say "done" without verification.
- **Handle all errors explicitly**: No silent failures. Every error case must be addressed with proper logging and user feedback.
- **Write clear, obvious code**: No clever tricks. Code should be maintainable by someone who doesn't know the original context.
- **Make incremental, testable changes**: Small, focused commits that can be easily reviewed and debugged.

## Security Requirements

*Security standards that must be followed in all code*

### Data Protection
- **Never store secrets in code**: No API keys, passwords, or sensitive data in commits. Use environment variables and secure storage.
- **Sanitize logs**: Never log passwords, tokens, personal data, or other sensitive information.
- **Minimize data collection**: Only collect and store data that is essential for functionality.

### Input Validation
- **Validate and sanitize all inputs**: Never trust external user input. Validate types, ranges, formats, and sanitize before processing.
- **Use parameterized queries**: Prevent SQL injection with prepared statements and parameterized queries.
- **Avoid dynamic code execution**: Never use eval() or execute user-provided code as code.

### Infrastructure
- **Use HTTPS everywhere**: Encrypt all data in transit with TLS 1.2 or higher.
- **Fail securely**: Errors should not leak sensitive information about system internals or data.
- **Treat external user input as potentially hostile**: Design with the assumption that every input is a potential attack vector.

## Code Quality

*Standards for writing maintainable, reliable code*

- **No clever tricks**: Clear, obvious code only.
- **Descriptive naming**: Functions and variables should explain their purpose without comments.
- **Single responsibility**: Each function, class, or module does one thing well.
- **Explicit error handling**: No silent failures or ignored error conditions.
- **Simplicity first**: Remove everything non-essential. Simple solutions are easier to debug and maintain.
- **Self-describing code first**: Write code that explains itself through clear naming, logical structure, and obvious flow.
- **Comments only when valuable**: Only comment when the code cannot be made self-explanatory.
- **Explain "why" not "what"**: Comments should explain reasoning, business logic, or non-obvious decisions.

## Development Process

*Workflow, testing, and version control practices*

### Testing
- **Write testable code**: Code that's hard to test is usually poorly designed.
- **Test behavior, not implementation**: Tests should verify what the code does, not how.
- **Independent tests**: Tests shouldn't depend on each other or external state.

### Version Control
- **Atomic commits**: One logical change per commit with clear messages.
- **Conventional commits**: Use consistent format (feat:, fix:, docs:, etc.).

### Workflow Management
For daily development tasks, use the structured commands in `@claude/commands/` (code-review, security-audit, functional-test, etc.).

For structured feature development, requirements gathering, and task management, use the [claude-code-spec-workflow](https://github.com/Pimzino/claude-code-spec-workflow) system on a per-project basis.

## Reference

*Detailed guidelines for specific scenarios*

### Code Organization
- **Follow existing code patterns**: Mimic established conventions for naming, organization, and architecture.
- **Follow security standards**: Never store secrets in code, validate all inputs, use HTTPS everywhere, and treat user input as potentially hostile.
