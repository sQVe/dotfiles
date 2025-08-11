# Universal development guidelines

Essential principles for all development work. Use `@claude/commands/` for specific tasks.

## Core principles

_Non-negotiables that override everything else_

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

## Code style guidelines

### TypeScript

**Basic Patterns:**

- Prefer `??` over `||` for null checks
- Prefer arrow functions over `function` declarations
- Use explicit checks rather than using truthiness (`if (x)`) or falsiness (`if (!x)`)
- Use optional chaining `?.` when possible

**Type Safety & Declarations:**

- Prefer `const` over `let` when values don't change
- Use `unknown` instead of `any` for better type safety
- Prefer type unions (`string | number`) over `any`
- Use `as const` for immutable object/array literals
- Prefer `interface` for object shapes, `type` for unions/primitives

**Modern TypeScript Patterns:**

- Use template literal types for string validation
- Prefer `Record<K, V>` over `{ [key: string]: V }`
- Use `satisfies` operator for better inference while maintaining type checking
- Prefer destructuring with type annotations: `const { name }: { name: string } = obj`

**Error Handling:**

- Use discriminated unions for result types instead of throwing
- Prefer `Result<T, E>` or `Option<T>` patterns for explicit error handling

**Import/Export:**

- Prefer named imports over default imports for better refactoring
- Use `import type` for type-only imports

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
