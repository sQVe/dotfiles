# Code Style Command

Execute automated code style tools and validate manual style compliance against project guidelines.

## Usage

```
/code-style <code-target>
```

## Instructions

You are helping improve code style and adhere to project guidelines.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Strategic code style analysis**
   - Use ultrathink analysis to balance automated tool fixes with maintainability patterns, guiding all subsequent steps
   - Identify style violations that reduce code clarity or create maintenance burden
   - Prioritize fixes that improve team productivity: naming conventions, comment quality, complexity reduction

3. **Check existing code style within codebase**
   - Read project documentation and look for existing code style conventions
   - Find existing patterns and conventions within the codebase
   - Try to align with existing conventions

4. **Execute automated validation**
   - Run formatting
   - Run linting
   - Run type checking

5. **Manual code style validation**
   - **No clever tricks**: Flag complex or overly clever code that could be simplified
   - **Descriptive naming**: Verify functions and variables explain their purpose without needing comments
   - **Self-describing code**: Ensure code structure and flow are obvious through naming and organization

6. **Manual comment validation**
   - Find all comments within code target.
   - Ensure comments, one by one, follow the guidelines below:
     - **Remove redundant comments**: Delete comments that don't add value
     - **Verify comment purpose**: Ensure each comment explains "why" (reasoning, business logic) rather than "what" (code mechanics)
     - **Check comment formatting**: Validate that comments end with proper punctuation (., ?, or !)

7. **Generate comprehensive report**
   - Mark manual violations as `CRITICAL` regardless of automated validation status
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include specific locations: Provide file paths and line numbers for each issue
   - Add remediation guidance: For each violation, suggest specific fixes or improvements
   - Summarize tool results: Report which automated tools ran successfully vs failed

## Examples

```bash
# Validate specific directory
/code-style src/components/

# Validate all changed files
/code-style changes

# Validate specific file
/code-style Button.tsx
```
