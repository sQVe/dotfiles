# Implement solution for tracked GitHub or Linear issue

<instructions>
  <context>
    Implement a solution for issue $ARGUMENTS by analyzing the problem and making focused code changes.
  </context>

  <requirements>
    - GitHub issue number or Linear issue ID
    - Access to codebase where the issue occurs
    - Development environment for making code changes
    - Debugging tools and ability to reproduce the issue
    - Validation tools to verify the fix resolves the problem
  </requirements>

  <execution>
    1. **Validate and analyze the issue**
       - Verify $ARGUMENTS is provided (GitHub issue ID or Linear issue ID required)
       - If no argument provided, show error: "Please specify issue to implement (e.g., '#123', 'LIN-456')"
       - Fetch issue details for $ARGUMENTS from GitHub/Linear
       - Reproduce the problem using provided steps or investigation
       - Identify root cause through debugging and code analysis

    2. **Implement the solution**
       - Design targeted changes that address the root cause
       - Make focused code changes following project patterns
       - Include appropriate error handling and documentation

    3. **Validate the resolution**
       - Verify the original issue is resolved through testing
       - Run tests to ensure no regressions introduced
       - Confirm the solution works in the reported conditions
  </execution>

  <validation>
    - [ ] Issue reproduced and root cause identified
    - [ ] Solution addresses the underlying problem, not just symptoms
    - [ ] Code changes are focused and follow project patterns
    - [ ] Original issue is resolved through testing
    - [ ] No regressions introduced in existing functionality
    - [ ] Fix works in conditions similar to the reported issue
  </validation>

  <workflow>
    **Prerequisites for issue implementation:**
    - `/debug:reproduce` - Confirm issue reproduction before implementation
    - `/debug:analyze` - Understand root cause through systematic analysis
    - `/research:codebase` - Study existing patterns for consistent implementation

    **After implementation:**
    - `/validate:code` - Run automated quality checks on changes
    - `/validate:tests` - Ensure tests cover the fix and prevent regression
    - `/validate:functionality` - Manually verify the fix works in realistic scenarios
    - `/finalize:commit` - Create focused commit with clear message
  </workflow>

  <examples>
    ```bash
    # Implement solution for GitHub issue
    /implement:issue #923

    # Process: analyze issue → reproduce problem → implement solution → validate fix
    # Result: Targeted code changes that resolve the reported issue
    ```

    ```bash
    # Example: Authentication bug resolution
    /implement:issue #456

    # Process includes:
    # - Fetch GitHub issue: "Users can't log in with special characters in password"
    # - Reproduce: Test login with password containing @#$% characters
    # - Debug: Identify URL encoding issue in login endpoint
    # - Implement: Fix parameter encoding in authentication middleware
    # - Validate: Test with various special characters, verify no regressions
    ```
  </examples>
</instructions>
