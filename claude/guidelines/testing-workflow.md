# Testing Workflow

## When to Write Tests

- **Before implementation** (TDD): Write failing tests first, then implement to make them pass
- **During implementation**: Add tests as you build new functionality
- **Include tests by default**: Every new feature, bug fix, or refactor should include appropriate tests unless there are compelling technical reasons to defer

## Test Types Priority

1. **Unit tests**: Test individual functions/methods in isolation
2. **Integration tests**: Test how components work together
3. **End-to-end tests**: Test complete user workflows (sparingly, high maintenance)

## Test Coverage Expectations

- **Critical paths**: 100% coverage for core business logic
- **Edge cases**: Test error conditions, boundary values, null/empty inputs
- **Regression**: Add tests for every bug found to prevent recurrence

## Testing Commands

- Check package.json, Makefile, or README for test commands
- Common patterns: `pnpm test`, `go test`, `make test`, and `./scripts/test`.
- Always run tests before committing changes

## Test Organization

- **Co-locate**: Keep tests near the code they test
- **Clear naming**: Test names should describe the scenario and expected outcome
- **Single responsibility**: One test should verify one behavior
- **Arrange-Act-Assert**: Structure tests with clear setup, execution, and verification

## Red-Green-Refactor Cycle

1. **Red**: Write a failing test
2. **Green**: Write minimal code to make it pass
3. **Refactor**: Improve code while keeping tests green
4. **Repeat**: Continue the cycle for each new requirement
