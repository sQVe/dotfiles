# Code Review Command

Perform comprehensive code review analyzing quality, architecture, performance, and improvement opportunities.

## Usage

```
/code-review <code-changes-or-component>
```

## Instructions

You are helping conduct a thorough code review.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Analyze the provided code/changes**
   - Determine scope, affected components, and potential impact
   - Identify the type of changes (new features, bug fixes, refactoring)
   - Understand the business context and requirements

3. **Review code quality and architecture**
   - **Code clarity**: Flag unnecessary complexity and code smells
   - **Separation of concerns**: Check component coupling and responsibilities
   - **Single responsibility**: Verify each function, class, or module does one thing well
   - **Appropriate abstractions**: Avoid over-engineering and premature optimization
   - **Simplicity first**: Identify non-essential complexity that can be removed
   - **Anti-patterns**: Identify potential bugs and design issues

4. **Review performance and security**
   - **Performance bottlenecks**: Identify optimization opportunities
   - **Race conditions**: Look for concurrency and edge case issues
   - **Resource management**: Verify proper cleanup and memory handling
   - **Security vulnerabilities**: Check input validation and authentication issues
   - **Error handling**: Verify explicit error handling with no silent failures

5. **Generate comprehensive report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include specific locations: Provide file paths and line numbers for each issue
   - Add remediation guidance: Suggest specific fixes and improvements with clear rationale
   - Prioritize recommendations: List most important changes first

## Examples

```bash
# Review all modified files
/code-review "changes"

# Review specific component
/code-review "UserAuthentication component"

# Review specific files
/code-review "src/auth/login.ts"
```
