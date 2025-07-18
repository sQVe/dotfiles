# Resolve ad-hoc problems from natural language descriptions

<instructions>
  <context>
    Implement a solution for the described problem $ARGUMENTS by analyzing the issue and making focused code changes.
  </context>

  <requirements>
    - Clear problem description or symptoms
    - Access to relevant codebase areas
    - Development environment for making code changes
    - Debugging tools to investigate the problem
    - Testing capabilities to verify the solution
  </requirements>

  <execution>
    1. **Validate and understand the problem**
       - Verify $ARGUMENTS is provided (problem description required)
       - If no argument provided, show error: "Please specify problem to resolve (e.g., 'login button not working on mobile')"
       - Analyze the problem description $ARGUMENTS
       - Investigate the codebase to understand the issue
       - Reproduce the problem if possible through debugging

    2. **Design and implement solution**
       - Design targeted changes that address the problem
       - Make focused code changes following project patterns
       - Include appropriate error handling and documentation

    3. **Verify the solution**
       - Test that the problem is resolved
       - Ensure no regressions introduced
       - Validate the fix works as expected

  </execution>

  <validation>
    - [ ] Problem description understood and investigated
    - [ ] Root cause identified through analysis
    - [ ] Solution addresses the underlying problem
    - [ ] Code changes are focused and follow project patterns
    - [ ] Problem is resolved through testing
    - [ ] No regressions introduced in existing functionality
  </validation>

  <examples>
    ```bash
    # Resolve described problem
    /implement:resolve "Login button not working on mobile devices"

    # Process: understand problem → investigate code → implement solution → verify fix
    # Result: Targeted code changes that resolve the described issue
    ```

    ```bash
    # Example: Performance problem resolution
    /implement:resolve "API responses are very slow for large datasets"

    # Process includes:
    # - Analyze: "API responses slow for large datasets"
    # - Investigate: Profile API endpoints and database queries
    # - Debug: Identify N+1 query problem in user data fetching
    # - Implement: Add query optimization and eager loading
    # - Verify: Test with large datasets, confirm improved performance
    ```

  </examples>
</instructions>
