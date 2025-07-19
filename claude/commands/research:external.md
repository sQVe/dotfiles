# Research external documentation, patterns, and best practices

<instructions>
  <context>
    Research external documentation, best practices, implementation patterns, and coding standards for $ARGUMENTS to gather comprehensive knowledge before implementation.
  </context>

  <requirements>
    - Clear technology, framework, pattern, or approach to research
    - Access to Ref MCP for documentation and best practices research
    - Internet access for gathering external resources and industry standards
  </requirements>

  <execution>
    1. **Quick analysis: External research scope and strategy**
       - Analyze $ARGUMENTS research target and identify efficient external research strategy
       - Plan research areas: documentation, best practices, implementation examples, security considerations
       - Determine optimal research sequence for comprehensive understanding

    2. **Documentation and standards research**
       - Verify $ARGUMENTS is provided (technology/framework/pattern to research required)
       - If no argument provided, show error: "Please specify what to research (e.g., 'JWT authentication', 'React performance', 'error handling patterns')"
       - Use Ref MCP to search for official documentation and API references for $ARGUMENTS
       - Find comprehensive guides and getting-started resources
       - Locate API documentation and usage examples
       - Research current industry standards and recommendations

    3. **Pattern and best practices investigation**
       - Research established patterns and conventions for $ARGUMENTS
       - Analyze framework-specific patterns and implementation approaches
       - Find security considerations and common pitfalls to avoid
       - Gather performance optimization techniques and recommendations
       - Study testing patterns and quality assurance approaches
       - Research current industry best practices and established patterns

    4. **Implementation examples and comparison analysis**
       - Collect code samples and implementation examples
       - Find integration patterns with common frameworks and libraries
       - Compare different pattern implementations and their trade-offs
       - Analyze suitability for different project contexts and constraints
       - Identify testing approaches and validation strategies
       - Document pattern variations and their specific use cases
  </execution>

  <validation>
    - [ ] Official documentation and API references located and reviewed
    - [ ] Current industry standards and recommendations researched
    - [ ] Best practices and security considerations identified
    - [ ] Implementation examples and patterns collected
    - [ ] Pattern variations and use cases documented
    - [ ] Performance implications and optimization techniques analyzed
    - [ ] Testing strategies and quality assurance approaches researched
    - [ ] Common pitfalls and gotchas documented
    - [ ] Framework-specific patterns and conventions understood
    - [ ] Implementation trade-offs and suitability analysis completed
  </validation>

  <workflow>
    **Part of research workflow:**
    - `/research:codebase` - Understand internal patterns first (recommended)
    - `/research:external` - Research external documentation and patterns (current)
    - `/research:dependencies` - Analyze related dependencies if needed

    **Prerequisites:** Understanding of what to research (from codebase analysis or requirements)
    **Next steps:** `/plan:synthesis` to combine findings or continue with planning
    **Best used with:** `/research:codebase` for comprehensive understanding
  </workflow>

  <examples>
    ```bash
    # Research JWT authentication best practices
    /research:external "JWT authentication best practices"

    # Process: documentation search → best practices → patterns → examples
    # Result: Comprehensive guide on JWT implementation, security patterns, and best practices
    ```

    ```bash
    # Research coding patterns and standards
    /research:external "error handling patterns"

    # Process includes:
    # - Research industry best practices for error handling
    # - Analyze different error handling patterns and approaches
    # - Study framework-specific error handling conventions
    # - Compare pattern implementations and trade-offs
    # - Document pattern variations and use cases
    # - Provide implementation guidelines and examples
    ```

    ```bash
    # Example: React performance research with patterns
    /research:external "React performance optimization"

    # Process includes:
    # - Official React docs on performance optimization
    # - Best practices: memoization, virtualization, code splitting
    # - Security: XSS prevention, safe rendering patterns
    # - Pattern analysis: different optimization approaches and trade-offs
    # - Examples: useMemo, useCallback, React.lazy implementations
    # - Testing: performance testing strategies and tools
    ```

  </examples>
</instructions>
