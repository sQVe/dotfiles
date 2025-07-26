# Validate Command

Execute automated validation checks including testing and builds.

## Usage

```
/validate <validation-scope>
```

## Instructions

You are helping validate code through automated checks and testing pipelines.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Identify available automated tools**
   - Discover test scripts, build commands, and CI/CD configurations
   - Check package.json, Makefile, or other build files for available commands
   - Identify linting, formatting, and type-checking tools already configured

3. **Execute automated testing**
   - **Unit tests**: Run all unit tests and collect coverage data
   - **Integration tests**: Execute integration test suites
   - **End-to-end tests**: Run E2E tests if available
   - **Performance tests**: Execute automated performance benchmarks

4. **Run build and compilation checks**
   - **Build process**: Execute full build to catch compilation errors
   - **Dependency validation**: Check for dependency conflicts and security issues
   - **Bundle analysis**: Verify build output size and optimization

5. **Generate automated validation report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include tool output summaries: Test results, coverage percentages, build status
   - List failing checks: Provide specific command outputs and error messages
   - Add automation guidance: Suggest missing automated checks or CI improvements
   - Provide quick fixes: Include commands to resolve common automated check failures

## Examples

```bash
# Validate all automated checks for changed files
/validate "changes"

# Run complete automated validation suite
/validate "all"

# Focus on testing automation only
/validate "tests"
```
