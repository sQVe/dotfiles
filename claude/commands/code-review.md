# Code Review Command

Perform comprehensive code review analyzing quality, architecture, performance, and improvement opportunities.

## Usage
```
/code-review <code-changes-or-component>
```

## Instructions
You are helping conduct a thorough code review. Follow these steps:

1. **Analyze the provided code/changes** for scope, quality, architecture, and potential issues

2. **Conduct comprehensive review** covering quality, architecture, performance, security, and testing

3. **Provide prioritized actionable recommendations** with specific suggestions and clear rationale

## Guidelines

### **Review Focus Areas:**
- Code clarity and unnecessary complexity
- Code smells, anti-patterns, and potential bugs
- Separation of concerns and component coupling
- Appropriate abstractions - avoid over-engineering
- Premature optimization and excessive abstraction layers

### **Security & Quality:**
- Security vulnerabilities and input validation issues
- Performance bottlenecks and optimization opportunities
- Race conditions and edge cases
- Resource management and cleanup
- System scalability impact

### **Testing & Documentation:**
- Test coverage and quality of test cases
- Missing or outdated inline documentation
- Comments explain "why" not "what" and end with periods
- Edge case and error scenario coverage

## Examples
```bash
# Review all modified files
/code-review "changes"

# Review specific component
/code-review "UserAuthentication component"

# Review specific files
/code-review "src/auth/login.ts"
```
