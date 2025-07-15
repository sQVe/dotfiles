# Completion workflow

*Before completion: Validation and quality*

### Required validation commands

**Run the project's validation commands before completion.**

Check for testing commands, linters, formatters, and type checkers in project files (package.json, Makefile, README, etc.).

**Validation requirements:**
- **All code quality checks must pass** - linting, formatting, type checking.
- **All tests must pass** - no skipping or ignoring failures.
- **Manual testing of key user paths** - verify the primary use cases and critical features work as expected.
- **Build process completes successfully** - if applicable to the project.

### Pre-completion checklist

**Before marking any task as complete:**

- [ ] **Code validates** - lint, typecheck, and tests all pass.
- [ ] **Functionality verified** - manually tested core use cases.
- [ ] **Error cases handled** - tested failure scenarios.
- [ ] **Documentation updated** - if public APIs or behavior changed.
- [ ] **Security reviewed** - no sensitive data exposed or logged.
- [ ] **Performance acceptable** - no obvious bottlenecks introduced.
- [ ] **Implementation notes updated** - key decisions and lessons documented.