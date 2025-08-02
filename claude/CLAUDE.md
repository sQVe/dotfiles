# Universal development guidelines

Essential principles for all development work. Use `@claude/commands/` for specific tasks.

## Core principles

_Non-negotiables that override everything else_

- **Use Serena** - Use Serena when possible
- **Research first** - Find current best practices and patterns
- **Minimize comments** - Write self-documenting code; only comment for complex business logic or non-obvious decisions
- **Ask clarifying questions** - Never assume requirements or edge cases
- **Understand existing patterns** - Analyze codebase structure and conventions
- **Simplicity first** - Remove everything non-essential
- **Single responsibility** - Each function/class/module does one thing well
- **Write obvious code** - No clever tricks, maintainable by anyone
- **Validate before completion** - Never say "done" without verification
- **Handle all errors explicitly** - No silent failures, proper logging required
- **Make incremental changes** - Small, focused, testable commits

## Testing principles

_Comprehensive testing is mandatory for all code_

- **Test-first mentality** - Write tests before or alongside implementation, never as an afterthought
- **Test pyramid adherence** - Majority unit tests, moderate integration tests, minimal E2E tests
- **Coverage with purpose** - Aim for high coverage through meaningful tests, not just numbers
- **Test quality standards** - Clear naming, isolated tests, proper assertions, no test interdependencies
- **Error path testing** - Explicitly test failure scenarios, edge cases, and error handling paths
- **Test maintenance** - Keep tests simple, fast, and maintainable; refactor tests with code changes

## Comment guidelines

**Core philosophy:**

- Comment the "why" (reasoning, business logic) rather than "what" (code mechanics).
- Ensure comments end with proper punctuation (., ?, or !).

**When comments add value:**

- **Business logic**: `// Apply 15% discount for premium customers.`
- **Complex algorithms**: `// Use binary search for O(log n) performance.`
- **Non-obvious decisions**: `// Retry 3 times due to flaky external API.`
- **Workarounds**: `// TODO: Remove when bug #123 is fixed.`
- **Complex conditions**: `// Regex matches IPv4 addresses excluding private ranges.`
- **Rejected alternatives**: `// Tried async/await but caused memory leaks in tight loops.`
- **Assumptions**: `// Assumes input is already validated by middleware.`
- **Performance implications**: `// O(n²) operation, acceptable for small datasets only.`

**Avoid redundant comments:**

- **Function name repetition**: `// Calculate total` above `calculateTotal()`
- **Obvious operations**: `// Increment counter` above `counter++`
- **Variable explanations**: `// User name` above `const userName = getUser().name`
- **Setter/getter descriptions**: `// Set the value` above `setValue(x)`
- **Loop descriptions**: `// Loop through items` above `for (item of items)`
