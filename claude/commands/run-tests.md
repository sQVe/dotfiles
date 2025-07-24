# Run Tests Command

Execute comprehensive test validation with coverage analysis to ensure code quality standards.

## Usage
```
/run-tests <test-scope>
```

## Instructions
You are helping validate code through comprehensive testing. Follow these steps:

1. **Execute comprehensive testing** including unit, integration, and end-to-end tests with coverage analysis

2. **Analyze test quality and coverage** identifying gaps and improvement opportunities

3. **Generate testing report** with results, coverage metrics, and actionable recommendations

## Guidelines

### **Coverage Requirements:**
- **Unit:** 80% line, 70% branch coverage
- **Integration:** 70% API endpoints and data flows
- **End-to-End:** 100% critical user workflows
- **Overall:** 75% total project coverage
- **New Code:** 90% coverage requirement

### **Quality Standards:**
- Isolated, independent tests (no shared state)
- Deterministic and consistent results
- Descriptive test names explaining scenarios
- Clear arrange, act, assert structure
- Mock external dependencies, avoid testing third-party code

### **Performance & Analysis:**
- Unit tests: <30 seconds, Integration: <5 minutes, E2E: <15 minutes
- Individual tests: <10 seconds, Flaky rate: <2%
- Categorize failures: flaky, environmental, code defect, test issue
- Provide reproduction steps, logs, stack traces
- Flag environment fixes vs. code changes

## Examples
```bash
# Test only modified code areas
/run-tests "changes"

# Run complete test suite
/run-tests "all"

# Focus on unit tests only
/run-tests "unit"

# Execute integration tests
/run-tests "integration"
```
