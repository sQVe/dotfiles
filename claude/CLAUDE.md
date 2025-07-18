# Universal Development Guidelines

This establishes how we work together on code - through questions, dialogue, and iterative problem-solving. Instead of making assumptions, we build understanding together by exploring options and discussing trade-offs. The result is better code that we both understand and can confidently maintain.

## Critical Requirements

### Research and understanding

- **Research before writing code**: Find current best practices and patterns.
- **Ask clarifying questions about requirements**: Never assume requirements. Ask about user experience, edge cases, performance constraints, and security implications.
- **Understand existing codebase patterns**: Analyze current code structure, conventions, and libraries before making changes.

### Quality and safety

- **Validate before completion**: Never say "done" without verification.
- **Handle all errors explicitly**: No silent failures. Every error case must be addressed with proper logging and user feedback.
- **Follow security standards**: Never store secrets in code, validate all inputs, use HTTPS everywhere, and treat user input as potentially hostile.

### Communication and tracking

- **Track complex tasks systematically**: Break down complex features into manageable pieces.
- **Provide honest technical assessment**: If code has problems, explain specific issues. If approaches have limitations, quantify them clearly.
- **Preserve technical context**: Document key decisions and lessons learned for future reference.

### Code clarity

- **Write clear, obvious code**: No clever tricks. Code should be maintainable by someone who doesn't know the original context.
- **Make incremental, testable changes**: Small, focused commits that can be easily reviewed and debugged.
- **Follow existing code patterns**: Mimic established conventions for naming, organization, and architecture.

## Security Standards

### Data protection

- **Never store secrets in code**: No API keys, passwords, or sensitive data in commits. Use environment variables and secure storage.
- **Sanitize logs**: Never log passwords, tokens, personal data, or other sensitive information.
- **Minimize data collection**: Only collect and store data that is essential for functionality.

### Input validation

- **Validate and sanitize all inputs**: Never trust external user input. Validate types, ranges, formats, and sanitize before processing.
- **Use parameterized queries**: Prevent SQL injection with prepared statements and parameterized queries.
- **Avoid dynamic code execution**: Never use eval() or execute user-provided code as code.

### Infrastructure security

- **Use HTTPS everywhere**: Encrypt all data in transit with TLS 1.2 or higher.
- **Fail securely**: Errors should not leak sensitive information about system internals or data.
- **Treat external user input as potentially hostile**: Design with the assumption that every input is a potential attack vector.

## Code Quality Standards

### Core principles

- **No clever tricks**: Clear, obvious code only.
- **Descriptive naming**: Functions and variables should explain their purpose without comments.
- **Single responsibility**: Each function, class, or module does one thing well.
- **Explicit error handling**: No silent failures or ignored error conditions.
- **Simplicity first**: Remove everything non-essential. Simple solutions are easier to debug and maintain.

### Documentation

- **Self-describing code first**: Write code that explains itself through clear naming, logical structure, and obvious flow.
- **Comments only when valuable**: Only comment when the code cannot be made self-explanatory.
- **Explain "why" not "what"**: Comments should explain reasoning, business logic, or non-obvious decisions.

### Testing principles

- **Write testable code**: Code that's hard to test is usually poorly designed.
- **Test behavior, not implementation**: Tests should verify what the code does, not how.
- **Independent tests**: Tests shouldn't depend on each other or external state.

### Performance considerations

- **Measure before optimizing**: Use profiling tools to identify actual bottlenecks.
- **Choose appropriate algorithms**: Consider time/space complexity for data structures.

### Version control

- **Atomic commits**: One logical change per commit with clear messages.
- **Conventional commits**: Use consistent format (feat:, fix:, docs:, etc.).

## Workflow Commands

Use specialized commands for specific development phases:

- **Research**: `/research:codebase`, `/research:external`, `/research:prime`
- **Planning**: `/plan:init`, `/plan:requirements`, `/plan:workflow`, `/plan:synthesis`
- **Implementation**: `/implement:issue`, `/implement:refactor`, `/implement:resolve`
- **Validation**: `/validate:code`, `/validate:tests`, `/validate:quality`, `/validate:style`
- **Debugging**: `/debug:analyze`, `/debug:reproduce`, `/debug:performance`, `/debug:production`
- **Finalization**: `/finalize:commit`, `/finalize:pr`, `/finalize:memory`

Each command provides structured workflows for its specific development phase. Use commands instead of manually following detailed procedures.
