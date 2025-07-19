# Run test suite and analyze coverage for code changes

<instructions>
  <context>
    Execute comprehensive test validation with coverage analysis for $ARGUMENTS scope to ensure code changes meet quality standards.
  </context>

  <requirements>
    - Project testing framework configured and functional
    - Test coverage tools available and configured
    - Clear scope specification for test execution strategy
    - Access to relevant test files and modified code areas
  </requirements>

  <execution>
    1. **Scope identification and test execution**
       - Verify $ARGUMENTS is provided (scope required: "changes", "all", "unit", or "integration")
       - If no scope provided, show error: "Please specify test scope (e.g., 'changes', 'all', 'unit', 'integration')"
       - Execute tests for specified scope with appropriate test runner
       - Ensure all tests pass with no failures or skipped tests

    2. **Coverage analysis and assessment**
       - Generate test coverage reports for the specified scope
       - Assess coverage percentage for new or changed code areas
       - Identify any missing test cases for edge conditions and boundary cases
       - Verify integration tests cover cross-component interactions

    3. **Gap identification and recommendations**
       - Document areas with insufficient test coverage
       - Identify missing test scenarios for critical functionality
       - Recommend specific test cases for uncovered edge conditions
       - Flag any brittle or flaky tests that need attention
  </execution>

  <validation>
    - [ ] Scope argument provided and validated
    - [ ] All executed tests pass without failures or skips
    - [ ] Test coverage meets project standards for specified scope
    - [ ] Coverage gaps identified and documented
    - [ ] Missing test scenarios clearly identified
    - [ ] Integration test coverage verified for cross-component interactions
    - [ ] Specific recommendations provided for coverage improvements
  </validation>

  <examples>
    ```bash
    # Test only modified areas
    /validate:tests "changes"

    # Process: identify changed files → run related tests → analyze coverage
    # Result: Focused validation with coverage analysis for modified code
    ```

    ```bash
    # Run complete test suite
    /validate:tests "all"

    # Process: execute full test suite → comprehensive coverage analysis
    # Result: Complete test validation with full coverage report
    ```

    ```bash
    # Run only unit tests
    /validate:tests "unit"

    # Process: execute unit test suite → analyze unit test coverage
    # Result: Fast validation focused on individual component testing
    ```

    ```bash
    # Run only integration tests
    /validate:tests "integration"

    # Process: execute integration tests → analyze cross-component coverage
    # Result: Validation of component interactions and system integration
    ```

    ```bash
    # Example coverage analysis results
    # Coverage: 94% overall, 87% on new code
    # Gaps: Error handling in payment processing needs tests
    # Missing: Integration tests for user registration flow
    # Recommendations: Add tests for timeout scenarios and validation edge cases
    ```

  </examples>
</instructions>
