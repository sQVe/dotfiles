# Create prioritized improvement recommendations

<instructions>
  <context>
    Transform findings from validation analysis into prioritized, actionable improvement recommendations for $ARGUMENTS with specific implementation guidance.
  </context>

  <requirements>
    - Understanding of code quality, security, and performance standards
    - Access to validation results or ability to analyze target scope
    - Knowledge of project architecture and improvement patterns
  </requirements>

  <execution>
    1. **Ultrathink: Improvement analysis strategy**
       - Use sequential thinking to analyze $ARGUMENTS improvement scope and plan assessment approach
       - Break down improvement areas: code quality, security, performance, maintainability, architecture, technical debt
       - Consider improvement methodologies: impact analysis, effort estimation, prioritization frameworks
       - Plan improvement identification sequence focusing on highest value and feasibility

    2. **Gather scope and analysis**
       - Gather findings from recent validation commands or perform fresh analysis
       - Review existing code quality, security, and performance characteristics

    3. **Identify and prioritize improvements**
       - Identify specific enhancement opportunities across security, performance, maintainability
       - Analyze technical debt and refactoring opportunities with measurable benefits
       - Prioritize recommendations by impact versus implementation effort
       - Consider long-term maintainability and scalability implications

    4. **Format actionable recommendations**
       - Create specific, implementable suggestions with clear rationale and examples
       - Provide concrete code examples or implementation patterns where applicable
       - Include effort estimates and expected benefits for each recommendation
  </execution>

  <validation>
    - [ ] Scope identified and appropriate code analyzed
    - [ ] Improvement opportunities identified across quality, security, performance
    - [ ] Recommendations prioritized by impact versus effort analysis
    - [ ] Each suggestion includes specific implementation guidance
    - [ ] Concrete code examples or patterns provided where applicable
    - [ ] Benefits and effort estimates included
  </validation>

  <workflow>
    **Improvement planning workflow:**
    - `/validate:code` → `/validate:security` → `/validate:tests` - Gather current state analysis
    - `/plan:improvements` - Create prioritized improvement recommendations (current)
    - `/implement:refactor` or `/implement:optimization` - Execute high-priority improvements
    - `/validate:functionality` - Ensure improvements don't break existing features

    **Prerequisites:** Code analysis completed, current state understood
    **Next steps:** Implementation of prioritized improvements
    **Best timing:** After validation phase, before major feature work
  </workflow>

  <examples>
    ```bash
    # Generate improvement plan for specific component
    /plan:improvements Button.tsx

    # Process: analyze component → identify opportunities → prioritize → format recommendations
    # Result: Specific improvements with implementation guidance and priority ranking
    ```

    ```bash
    # Comprehensive project improvement planning
    /plan:improvements all

    # Process: analyze codebase → identify patterns → prioritize impact → create roadmap
    # Result: Prioritized improvement roadmap with specific recommendations and effort estimates
    ```

    ```bash
    # Example improvement recommendations
    # HIGH IMPACT (2h effort): Extract common error handling → reduces 40% code duplication
    # MEDIUM IMPACT (4h effort): Add response caching → improves API performance by 60%
    # LOW IMPACT (1h effort): Add JSDoc comments → improves developer experience
    # Code example: Extract error handler function with standardized logging pattern
    ```

  </examples>
</instructions>
