# Code quality

### Core principles

- **No clever tricks** - Clear, obvious code only.
- **Descriptive naming** - Functions and variables should explain their purpose without comments.
- **Single responsibility** - Each function, class, or module does one thing well.
- **Explicit error handling** - No silent failures or ignored error conditions.
- **Simplicity first** - Remove everything non-essential. Simple solutions are easier to debug and maintain.

### Code organization

- **Logical structure** - Group related functionality together.
- **Consistent patterns** - Follow established conventions within the codebase.
- **Minimal dependencies** - Avoid unnecessary external dependencies.
- **Clear interfaces** - Public APIs should be intuitive and well-defined.
- **Separation of concerns** - Business logic, data access, and presentation should be distinct.

### Documentation

- **Self-describing code first** - Write code that explains itself through clear naming, logical structure, and obvious flow.
- **Comments only when valuable** - Don't add comments for the sake of having comments. Only comment when the code cannot be made self-explanatory.
- **Explain "why" not "what"** - Comments should explain reasoning, business logic, or non-obvious decisions, not describe what the code does.
- **Comment complex logic** - When algorithms, business rules, or edge cases are inherently complex, explain the reasoning behind the approach.
- **Avoid redundant comments** - Don't comment obvious code like `i++; // increment i` or `return user; // return the user`.
- **Follow documentation standards** - See `@guidelines/documentation-workflow.md` for comprehensive documentation guidance.

### Error handling

- **Fail fast and clearly** - Detect problems early and provide useful error messages.
- **Handle errors at appropriate levels** - Don't catch and ignore unless you can meaningfully recover.
- **Log errors with context** - Include enough information to debug the issue.
- **Validate inputs** - Check assumptions about data at system boundaries.
- **Graceful degradation** - System should remain functional when non-critical components fail.

### Testing principles

- **Write testable code** - Code that's hard to test is usually poorly designed.
- **Test behavior, not implementation** - Tests should verify what the code does, not how.
- **Clear test names** - Test names should describe the scenario and expected outcome.
- **Independent tests** - Tests shouldn't depend on each other or external state.
- **Test edge cases** - Include boundary conditions and error scenarios.

### Performance considerations

- **Measure before optimizing** - Use profiling tools to identify actual bottlenecks.
- **Optimize for readability first** - Clear code is easier to optimize later.
- **Consider algorithmic complexity** - Choose appropriate data structures and algorithms.
- **Cache wisely** - Cache expensive operations, but avoid premature caching.
- **Monitor in production** - Track performance metrics that matter to users.

### Refactoring practices

- **Small, incremental changes** - Refactor in tiny steps with tests passing at each step.
- **One change at a time** - Don't mix refactoring with feature development.
- **Preserve behavior** - Refactoring should not change what the code does.
- **Remove dead code** - Delete unused functions, variables, and imports.
- **Extract for clarity** - Pull out complex logic into well-named functions.

### Code review standards

- **Review for understanding** - Can you understand what the code does and why?
- **Check for edge cases** - Are error conditions and boundary cases handled?
- **Verify tests** - Do tests actually cover the changed functionality?
- **Security considerations** - Look for potential vulnerabilities.
- **Performance impact** - Consider if changes could affect system performance.
- **Documentation updates** - Ensure relevant documentation is updated.

### Quality principles

- **Test coverage** - New code should be adequately tested
- **Style consistency** - Follow agreed-upon style guidelines
- **Security awareness** - Check for known vulnerabilities
- **Performance consciousness** - Avoid changes that significantly slow the system
