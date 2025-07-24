# Code Quality Command

Execute automated code quality tools and validate manual style compliance against project guidelines.

## Usage
```
/code-quality <code-target>
```

## Instructions
You are helping validate code quality through automated tools and manual review. Follow these steps:

1. **Execute automated validation** using formatting, linting, type checking, and build verification

2. **Conduct manual compliance review** against CLAUDE.md standards and language idioms

3. **Generate quality report** with automated fixes applied and actionable remediation steps

## Guidelines

### **Code Standards:**
- Comments end with periods
- Use descriptive names that explain purpose
- Prefer pure functions over stateful code
- Single responsibility per function
- Use named constants instead of magic numbers/strings
- No clever tricks - prioritize clarity over brevity
- Explicit error handling - no silent failures

### **Technical Requirements:**
- All linting and type checking must pass
- Consistent formatting per project standards
- No console.log or debug statements in production

## Examples
```bash
# Validate specific directory
/code-quality src/components/

# Validate all changed files
/code-quality changes

# Validate specific file
/code-quality Button.tsx
```
