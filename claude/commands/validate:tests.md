# Execute test validation with coverage analysis

<instructions>
  <context>
    Execute tests with coverage analysis for $ARGUMENTS to ensure code quality standards.
  </context>

  <requirements>
    - Testing framework and coverage tools configured
    - Clear scope specification for test execution
  </requirements>

  <execution>
    1. **Execute tests for scope**
       - Run tests for specified scope with appropriate test runner
       - Ensure all tests pass with no failures or skipped tests

    2. **Analyze coverage and gaps**
       - Generate coverage reports for the specified scope
       - Assess coverage percentage for new or changed code
       - Identify missing test cases for edge conditions
       - Verify integration tests cover cross-component interactions

    3. **Document recommendations**
       - Document areas with insufficient test coverage
       - Recommend specific test cases for uncovered scenarios
       - Flag any brittle or flaky tests that need attention
  </execution>

  <validation>
    - [ ] All tests pass without failures or skips
    - [ ] Coverage meets project standards for scope
    - [ ] Coverage gaps documented with recommendations
    - [ ] Integration test coverage verified
    - [ ] Flaky tests identified and flagged
  </validation>

  <workflow>
    **Part of validation workflow:**
    1. `/validate:code` - Automated linting, formatting, type checking
    2. `/validate:tests` - Test execution and coverage analysis (current)
    3. `/validate:functionality` - Manual user workflow verification
    4. `/validate:security` - Security validation if needed
    5. `/finalize:commit` - Create clean commits after validation

    **Prerequisites:** Code changes made, tests written
    **Next steps:** Address test failures and coverage gaps, continue validation
    **Best practices:** Run after each significant code change
  </workflow>

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
