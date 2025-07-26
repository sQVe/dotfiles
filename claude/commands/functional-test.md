# Functional Test Command

Perform comprehensive functional testing to verify user workflows, accessibility, and system behavior.

## Usage

```
/functional-test <feature-or-workflow>
```

## Instructions

You are helping validate that features work correctly for users through comprehensive testing.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Identify testing scope and environment**
   - Understand the feature or workflow to be tested
   - Identify available testing environments (local, staging, production)
   - Discover existing test suites and testing frameworks in use

3. **Execute core functionality testing**
   - **User workflows**: Test complete user journeys from start to finish
   - **Edge cases**: Validate behavior with invalid inputs, boundary conditions, error states
   - **Cross-browser/device compatibility**: Test across browsers and device types if applicable
   - **API functionality**: Validate endpoints, request/response formats, error handling

4. **Validate accessibility and performance**
   - **Accessibility standards**: Check WCAG compliance, keyboard navigation, screen reader compatibility
   - **Performance benchmarks**: Measure load times, response times, resource usage
   - **Load testing**: Test system behavior under expected and peak load conditions

5. **Generate comprehensive test report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include test results: Pass/fail status for each workflow tested
   - Document defects: Reproduction steps, expected vs actual behavior
   - Add performance metrics: Timing data and resource usage measurements
   - Provide remediation guidance: Specific fixes and improvements with priority

## Examples

```bash
# Validate user authentication workflow
/functional-test "user authentication"

# Test API functionality under load
/functional-test "REST API endpoints under production load"

# Validate payment processing
/functional-test "checkout and payment flow"
```
