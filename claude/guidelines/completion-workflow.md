# Completion workflow

*Before completion: Validation and quality*

### Required validation commands

**Run the project's validation commands before completion.**

For testing commands, follow @guidelines/testing-workflow.md guidance. Additionally check for linters, formatters, and type checkers in project files.

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
- [ ] **Implementation memory updated** - journal completed, patterns documented.

### Memory system completion

**Before completing complex implementations:**

- **Finalize implementation journal** - Complete all sections with lessons learned.
- **Extract reusable patterns** - Document architectural decisions, code patterns, and implementation approaches that could apply to similar features in this project.
- **Update project patterns** - Add new architectural decisions to `.claude/memory/patterns/`.
- **Document gotchas** - Add troubleshooting guidance to `.claude/memory/issues/`.

**Memory directory structure:**
```
.claude/memory/
├── features/    # Feature implementation journals
├── patterns/    # Reusable architectural patterns
└── issues/      # Common issues and solutions
```