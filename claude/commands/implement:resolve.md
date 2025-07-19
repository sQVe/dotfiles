# Resolve problems from descriptions or tracked issues

<instructions>
  <context>
    Implement a solution for the described problem or tracked issue $ARGUMENTS by analyzing the issue and making focused code changes.
  </context>

  <requirements>
    - Clear problem description, symptoms, or GitHub/Linear issue identifier
    - Access to relevant codebase areas and issue tracking systems
    - Development environment for making code changes
    - Testing capabilities to verify the solution
  </requirements>

  <execution>
    1. **Ultrathink: Problem resolution strategy**
       - Use sequential thinking to analyze $ARGUMENTS problem scope and plan resolution approach
       - Break down resolution process: problem understanding, root cause analysis, solution design, implementation, testing
       - Consider problem types: bug fixes, feature issues, integration problems, performance concerns
       - Plan resolution sequence prioritizing understanding, targeted fixes, and thorough validation

    2. **Understand the problem**
       - If $ARGUMENTS looks like an issue ID (starts with # or contains LIN-), fetch issue details from GitHub/Linear
       - Analyze the problem description or issue details
       - Reproduce the problem using provided steps or investigation
       - Investigate the codebase to understand the root cause

    3. **Design and implement solution**
       - Identify root cause through debugging and code analysis
       - Design targeted changes that address the underlying problem
       - Make focused code changes following project patterns
       - Include appropriate error handling and documentation

    4. **Verify the solution**
       - Verify the original problem is resolved through testing
       - Test that the fix works in the reported conditions
       - Ensure no regressions introduced in existing functionality
       - Confirm the solution works in realistic scenarios
  </execution>

  <validation>
    - [ ] Problem description understood and investigated
    - [ ] Issue reproduced and root cause identified
    - [ ] Solution addresses the underlying problem, not just symptoms
    - [ ] Code changes are focused and follow project patterns
    - [ ] Original problem is resolved through testing
    - [ ] No regressions introduced in existing functionality
  </validation>

  <workflow>
    **Problem resolution workflow:**
    - `/debug:reproduce` - Reproduce the issue first (recommended)
    - `/debug:analyze` - Understand root cause through systematic analysis
    - `/research:codebase` - Study existing patterns for consistent implementation
    - `/implement:resolve` - Implement targeted solution (current)
    - `/validate:code` - Run automated quality checks on changes
    - `/validate:tests` - Ensure tests cover the fix and prevent regression
    - `/validate:functionality` - Manually verify the fix works in realistic scenarios

    **Prerequisites:** Clear problem understanding (issue ID or description)
    **Next steps:** Validation workflow, then `/finalize:commit`
  </workflow>

  <examples>
    ```bash
    # Resolve described problem
    /implement:resolve "Login button not working on mobile devices"

    # Process: understand problem → investigate code → implement solution → verify fix
    # Result: Targeted code changes that resolve the described issue
    ```

    ```bash
    # Resolve GitHub issue
    /implement:resolve "#923"

    # Process: fetch issue details → reproduce problem → implement solution → validate fix
    # Result: Targeted code changes that resolve the tracked issue
    ```

    ```bash
    # Resolve Linear issue
    /implement:resolve "LIN-456"

    # Process: fetch Linear issue → analyze problem → implement solution → verify fix
    # Result: Focused implementation that addresses the tracked issue
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
