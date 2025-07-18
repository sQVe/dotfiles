# Analyze code for security vulnerabilities and performance issues

<instructions>
  <context>
    Research current standards then identify quality issues in $ARGUMENTS including security vulnerabilities, technical debt, and performance bottlenecks.
  </context>

  <requirements>
    - Accessible codebase with target files or components to analyze
    - Understanding of application architecture and technology stack
    - Access to dependency manifests and configuration files
    - Ability to research current security, performance, and quality standards
  </requirements>

  <execution>
    1. **Standards research and scope identification**
       - Verify $ARGUMENTS is provided (target required: files, components, or "all")
       - If no scope provided, show error: "Please specify what to analyze (e.g., 'Button.tsx', 'all')"
       - Research current security vulnerabilities and best practices for detected tech stack
       - Look up latest performance benchmarks and anti-patterns for project technologies
       - Find current accessibility guidelines and framework-specific quality standards

    2. **Security and quality analysis with current standards**
       - Apply researched security standards to scan for vulnerabilities and misconfigurations
       - Assess code complexity, coupling, and architectural consistency against current practices
       - Review error handling completeness using researched failure patterns
       - Check for code duplication and identify refactoring opportunities

    3. **Performance analysis with current benchmarks**
       - Profile critical paths using researched performance standards for the tech stack
       - Review resource usage patterns against current best practices
       - Assess logging, monitoring, and debugging capabilities with current observability standards
       - Identify performance bottlenecks using latest optimization patterns

  </execution>

  <validation>
    - [ ] Current standards research completed for project's technology stack
    - [ ] Security vulnerabilities documented with specific locations, severity levels, and standard references
    - [ ] Code quality issues identified with concrete examples and current best practice citations
    - [ ] Performance problems documented with measurable data and current benchmark comparisons
    - [ ] Error handling gaps catalogued with current failure pattern recommendations
    - [ ] Technical debt prioritized by maintenance impact using current refactoring practices
    - [ ] Findings include references to researched standards and guidelines used
    - [ ] Analysis scope clearly documented (what files/components were covered)
  </validation>

  <examples>
    ```bash
    # Deep quality analysis of specific component
    /validate:quality Button.tsx

    # Process: research current standards → apply to security scan → quality assessment → performance analysis
    # Result: Detailed findings with current standard references, prop validation gaps, and performance concerns
    ```

    ```bash
    # Comprehensive project quality assessment
    /validate:quality all

    # Process includes:
    # - Research: current security standards, performance benchmarks, quality practices for tech stack
    # - Security: apply researched standards to scan for vulnerabilities and misconfigurations
    # - Code quality: assess against current best practices, identify gaps and technical debt
    # - Performance: profile using current benchmarks, identify bottlenecks with standard references
    # - Result: Quality report with current standard citations and prioritized actionable findings
    ```

  </examples>
</instructions>
