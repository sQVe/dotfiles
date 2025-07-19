# Implement comprehensive test coverage

<instructions>
  <context>
    Write comprehensive tests for $ARGUMENTS through analysis of testing requirements and implementation of appropriate test strategies.
  </context>

  <requirements>
    - Understanding of testing frameworks and methodologies
    - Access to codebase and existing test structure
    - Knowledge of testing best practices and patterns
    - Ability to identify edge cases and test scenarios
  </requirements>

  <execution>
    1. **Quick analysis: Testing scope and comprehensive strategy**
       - Analyze $ARGUMENTS functionality and identify complete testing strategy
       - Plan testing types: unit, integration, edge cases, error scenarios
       - Determine optimal testing approach and framework usage

    2. **Test design and planning**
       - Identify all functions, methods, and components requiring tests
       - Map input/output scenarios and edge cases
       - Plan test data setup and teardown requirements
       - Design test structure following project conventions

    3. **Test implementation**
       - Write unit tests for core functionality and business logic
       - Implement integration tests for component interactions
       - Create edge case tests for boundary conditions
       - Add error handling and negative test scenarios
       - Write performance tests where appropriate
       - Ensure proper test isolation and cleanup

    4. **Test validation and optimization**
       - Verify test coverage meets quality standards
       - Validate tests catch intended issues and edge cases
       - Optimize test performance and maintainability
       - Document complex test scenarios and setup requirements
  </execution>

  <validation>
    - [ ] All core functionality covered with unit tests
    - [ ] Integration tests implemented for component interactions
    - [ ] Edge cases and boundary conditions tested
    - [ ] Error handling scenarios validated with tests
    - [ ] Test data setup and cleanup properly implemented
    - [ ] Tests follow project conventions and best practices
    - [ ] Test coverage meets quality standards
    - [ ] Complex test scenarios documented appropriately
  </validation>

  <workflow>
    **Part of implementation workflow:**
    1. `/implement:feature` or `/implement:refactor` - Code implementation
    2. `/implement:tests` - Write comprehensive tests (current)
    3. `/validate:tests` - Execute tests and verify coverage
    4. `/validate:code` - Automated quality checks
    5. `/finalize:commit` - Commit implementation with tests

    **Prerequisites:** Feature/component implementation complete or in progress
    **Next steps:** Run test validation, address coverage gaps
    **Best practices:** Write tests during or immediately after implementation
  </workflow>

  <examples>
    ```bash
    # Implement tests for new authentication feature
    /implement:tests "user authentication module"

    # Process: analyze scope → design tests → implement comprehensive coverage → validate
    # Result: Complete test suite for authentication functionality
    ```

    ```bash
    # Write tests for API endpoints
    /implement:tests "REST API endpoints for user management"

    # Process includes:
    # - Unit tests: input validation, business logic, data processing
    # - Integration tests: database interactions, external service calls
    # - Edge cases: invalid inputs, network failures, rate limiting
    # - Error scenarios: authentication failures, permission issues
    # - Performance tests: response times, load handling
    # - Documentation: complex setup, mock requirements
    ```

    ```bash
    # Example test implementation results
    # ✅ UserAuth.test.js created with 15 test cases
    #   - Unit tests: validateCredentials(), hashPassword(), generateToken()
    #   - Integration tests: login flow, session management, logout
    #   - Edge cases: empty inputs, invalid formats, expired tokens
    #   - Error scenarios: wrong password, account lockout, server errors
    # 
    # ✅ Test coverage: 94% (target: 90%+)
    # ✅ All tests passing with proper isolation
    # ✅ Mock setup documented for external dependencies
    # 
    # 📋 Next steps:
    # - Run /validate:tests to verify coverage
    # - Consider adding performance tests for high-load scenarios
    ```

  </examples>
</instructions>