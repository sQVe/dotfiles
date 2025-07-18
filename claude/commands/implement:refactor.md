# Improve code structure while preserving behavior

<instructions>
  <context>
    Systematically improve code structure, readability, and maintainability for $ARGUMENTS while preserving existing functionality through incremental, testable changes.
  </context>

  <requirements>
    - Target code or component to refactor specified as $ARGUMENTS
    - Comprehensive test coverage for code being refactored
    - Understanding of current functionality and behavior
    - Development environment with testing and validation tools
  </requirements>

  <execution>
    1. **Analyze current state and plan improvements**
       - Verify $ARGUMENTS is provided (code to refactor required)
       - If no argument provided, show error: "Please specify what to refactor (e.g., 'UserAuth.js', 'authentication module')"
       - Thoroughly analyze existing code structure and implementation patterns
       - Document current behavior and functionality comprehensively
       - Identify specific improvement opportunities: code smells, complexity, duplication
       - Plan incremental refactoring steps that preserve behavior

    2. **Execute incremental refactoring with validation**
       - Make small, focused changes that can be easily tested and reviewed
       - Ensure each step preserves existing functionality completely
       - Run tests after each incremental change to verify behavior preservation
       - Use git commits to create safe rollback points for each refactoring step
       - Apply established refactoring patterns: extract method, eliminate duplication, improve naming

    3. **Validate improvements and behavior preservation**
       - Execute complete test suite to ensure no functionality changes
       - Perform manual testing of critical user workflows if applicable
       - Verify that code is more readable and maintainable than before
       - Confirm that future changes will be easier to implement
       - Validate that technical debt has been reduced without introducing new issues
  </execution>

  <validation>
    - [ ] Target code analyzed and improvement opportunities identified
    - [ ] Refactoring plan created with incremental, safe steps
    - [ ] All existing tests pass before and after each change
    - [ ] Behavior preservation verified through testing
    - [ ] Code readability and maintainability demonstrably improved
    - [ ] Technical debt reduced without introducing new complexity
    - [ ] Future modifications will be easier to implement
    - [ ] All changes are reversible through git history
  </validation>

  <examples>
    ```bash
    # Refactor specific class or component
    /implement:refactor UserAuthentication.js

    # Process: analyze current code → plan improvements → incremental changes → validate behavior
    # Result: Improved code structure while preserving all existing functionality
    ```

    ```bash
    # Refactor complex function or module
    /implement:refactor "data processing module"

    # Process: analyze complexity → extract methods → eliminate duplication → improve naming → test
    # Result: More maintainable code with same behavior and easier future modifications
    ```

    ```bash
    # Example refactoring improvements applied
    # ✅ Extracted 3 methods from 80-line function for clarity
    # ✅ Eliminated 40% code duplication through shared utilities
    # ✅ Improved variable names for better self-documentation
    # ✅ Reduced cyclomatic complexity from 15 to 6
    # ✅ All 47 tests pass, behavior preserved
    ```
  </examples>
</instructions>