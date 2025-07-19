# Analyze codebase patterns, architecture, and system design

<instructions>
  <context>
    Analyze existing codebase patterns, implementations, and system architecture related to $ARGUMENTS to understand established conventions, architectural decisions, and overall system design.
  </context>

  <requirements>
    - Access to codebase for pattern and architectural analysis
    - Understanding of the feature, area, or architectural aspect to research
    - Ability to search and examine code across the project and understand system structure
  </requirements>

  <execution>
    1. **Quick analysis: Research scope and approach**
       - Analyze $ARGUMENTS research scope and identify efficient codebase exploration strategy
       - Plan investigation areas: patterns, architecture, implementation details, quality assessment
       - Determine optimal research sequence for comprehensive understanding

    2. **System structure and pattern analysis**
       - Map overall system structure and component organization for $ARGUMENTS
       - Find similar implementations across the codebase
       - Analyze existing patterns for naming conventions and coding styles
       - Examine architectural decisions and design patterns used
       - Study component organization and file structure approaches

    3. **Architectural and design pattern identification**
       - Identify architectural layers and their responsibilities
       - Analyze module boundaries and interface definitions
       - Document service interactions and communication patterns
       - Examine data flow and state management approaches
       - Review error handling and resilience patterns
       - Analyze integration patterns and external dependencies

    4. **Implementation consistency and quality review**
       - Check recent development activity and changes in related areas
       - Review current project state and any ongoing work that might conflict
       - Identify library choices and framework usage in similar features
       - Study testing patterns and coverage approaches used in similar code
       - Analyze performance optimization techniques already implemented
       - Review documentation patterns and comment conventions
       - Identify code quality standards and linting configurations
  </execution>

  <validation>
    - [ ] System structure and component organization mapped
    - [ ] Similar implementations identified and analyzed
    - [ ] Naming conventions and coding styles documented
    - [ ] Architectural layers and responsibilities identified
    - [ ] Design patterns and architectural patterns documented
    - [ ] Key architectural decisions and rationale understood
    - [ ] Integration patterns and external dependencies analyzed
    - [ ] Testing approaches and quality standards identified
    - [ ] Recent changes and ongoing work reviewed
    - [ ] Library choices and framework patterns documented
  </validation>

  <workflow>
    **Part of research workflow:**
    - `/research:prime` - Get project overview first (optional)
    - `/research:codebase` - Analyze internal patterns and architecture (current)
    - `/research:external` - Research external best practices and patterns
    - `/research:dependencies` - Analyze dependency health and security

    **Prerequisites:** None (can be first command)
    **Next steps:** Continue with external research or proceed to planning phase
    **Complements:** `/plan:requirements` for understanding implementation needs
  </workflow>

  <examples>
    ```bash
    # Research authentication patterns and architecture
    /research:codebase "authentication implementation patterns"

    # Process: find similar code → analyze patterns → map architecture → document conventions
    # Result: Understanding of auth implementation, architecture, and established patterns
    ```

    ```bash
    # Example: System architecture analysis
    /research:codebase "data flow architecture"

    # Process includes:
    # - Map overall system structure and data flow patterns
    # - Identify architectural layers (presentation, business, data)
    # - Analyze component interactions and communication patterns
    # - Study state management and data persistence approaches
    # - Document: architectural decisions and design rationale
    ```

    ```bash
    # Example: API endpoint patterns and architecture
    /research:codebase "REST API endpoint implementations"

    # Process includes:
    # - Map API architecture and endpoint organization
    # - Analyze naming conventions: /api/users vs /users vs /user
    # - Study error handling: how 404s, validation errors are handled
    # - Examine testing: integration tests, mocking patterns
    # - Document: established patterns for new endpoint implementation
    ```

  </examples>
</instructions>
