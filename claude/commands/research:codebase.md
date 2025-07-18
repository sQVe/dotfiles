# Analyze existing codebase patterns and conventions

<instructions>
  <context>
    Analyze existing codebase patterns and implementations related to $ARGUMENTS to understand established conventions and architectural decisions.
  </context>

  <requirements>
    - Access to codebase for pattern analysis
    - Understanding of the feature or area to research
    - Ability to search and examine code across the project
  </requirements>

  <execution>
    1. **Validate and analyze patterns**
       - Verify $ARGUMENTS is provided (pattern/area to analyze required)
       - If no argument provided, show error: "Please specify what to analyze (e.g., 'authentication patterns')"
       - Find similar implementations across the codebase for $ARGUMENTS
       - Analyze existing patterns for naming conventions and coding styles
       - Examine architectural decisions and design patterns used
       - Study component organization and file structure approaches

    2. **Implementation consistency review**
       - Check recent development activity and changes in related areas
       - Review current project state and any ongoing work that might conflict
       - Identify library choices and framework usage in similar features
       - Examine error handling and validation patterns

    3. **Testing and quality patterns**
       - Study testing patterns and coverage approaches used in similar code
       - Analyze performance optimization techniques already implemented
       - Review documentation patterns and comment conventions
       - Identify code quality standards and linting configurations
  </execution>

  <validation>
    - [ ] Similar implementations identified and analyzed
    - [ ] Naming conventions and coding styles documented
    - [ ] Architectural patterns and design decisions understood
    - [ ] Testing approaches and quality standards identified
    - [ ] Recent changes and ongoing work reviewed
    - [ ] Library choices and framework patterns documented
  </validation>

  <examples>
    ```bash
    # Research authentication patterns in codebase
    /research:codebase "authentication implementation patterns"

    # Process: find similar code → analyze patterns → document conventions
    # Result: Understanding of how auth is currently implemented and styled
    ```

    ```bash
    # Example: API endpoint patterns research
    /research:codebase "REST API endpoint implementations"

    # Process includes:
    # - Find existing API routes and controller patterns
    # - Analyze naming conventions: /api/users vs /users vs /user
    # - Study error handling: how 404s, validation errors are handled
    # - Examine testing: integration tests, mocking patterns
    # - Document: established patterns for new endpoint implementation
    ```
  </examples>
</instructions>