# Gather external knowledge for implementation planning

<instructions>
  <context>
    Research external documentation, best practices, and implementation patterns for $ARGUMENTS to gather knowledge before implementation.
  </context>

  <requirements>
    - Clear technology, framework, or approach to research
    - Access to Ref MCP for documentation and best practices research
    - Internet access for gathering external resources
  </requirements>

  <execution>
    1. **Validate and research documentation**
       - Verify $ARGUMENTS is provided (technology/framework to research required)
       - If no argument provided, show error: "Please specify what to research (e.g., 'JWT authentication', 'React performance')"
       - Use Ref MCP to search for official documentation and API references for $ARGUMENTS
       - Find comprehensive guides and getting-started resources
       - Locate API documentation and usage examples

    2. **Best practices investigation**
       - Research established patterns and conventions for $ARGUMENTS
       - Find security considerations and common pitfalls
       - Gather performance optimization techniques and recommendations

    3. **Examples and integration patterns**
       - Collect code samples and implementation examples
       - Find integration patterns with common frameworks
       - Identify testing approaches and validation strategies

  </execution>

  <validation>
    - [ ] Official documentation located and reviewed
    - [ ] Best practices and security considerations identified
    - [ ] Implementation examples and patterns collected
    - [ ] Common pitfalls and gotchas documented
    - [ ] Testing and validation approaches understood
  </validation>

  <examples>
    ```bash
    # Research JWT authentication
    /research:external "JWT authentication best practices"

    # Process: documentation search → best practices → examples
    # Result: Comprehensive guide on JWT implementation, security, and patterns
    ```

    ```bash
    # Example: React performance research
    /research:external "React performance optimization"

    # Process includes:
    # - Official React docs on performance optimization
    # - Best practices: memoization, virtualization, code splitting
    # - Security: XSS prevention, safe rendering patterns
    # - Examples: useMemo, useCallback, React.lazy implementations
    # - Testing: performance testing strategies and tools
    ```

  </examples>
</instructions>
