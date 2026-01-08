# Validate Command

Run validation checks: tests, builds, and linting.

## Usage

```
/validate <validation-scope>
```

## Instructions

1. **Identify available tools**
   - Check package.json, Makefile, or build files for commands
   - Find configured linting, formatting, and type-checking tools

2. **Execute testing**
   - Run unit tests and collect coverage
   - Execute integration and E2E tests if available
   - Run performance benchmarks if configured

3. **Run build checks**
   - Execute full build to catch compilation errors
   - Check for dependency conflicts and security issues
   - Verify build output size

4. **Generate report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include test results, coverage, and build status
   - List failing checks with error messages
   - Suggest fixes for common failures

## Examples

```bash
# Validate changed files only
/validate "changes"

# Run complete validation
/validate "all"

# Run tests only
/validate "tests"
```
