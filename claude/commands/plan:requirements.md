# Gather and clarify requirements through systematic questioning

<instructions>
  <context>
    Gather and clarify requirements for $ARGUMENTS through targeted questions and analysis to ensure complete understanding before implementation.
  </context>

  <requirements>
    - Clear feature or problem description to analyze
    - Understanding of project context and user needs
    - Access to stakeholders or requirement sources
  </requirements>

  <execution>
    1. **Gather user experience requirements**
       - Ask clarifying questions about user experience expectations
       - Determine core functionality vs nice-to-have features
       - Understand user workflows and interaction patterns
       - Identify accessibility and usability requirements

    2. **Define technical and integration requirements**
       - Determine configuration needs and sensible default values
       - Understand integration requirements with existing features
       - Identify data storage and persistence needs
       - Clarify API and external service dependencies

    3. **Specify quality and operational requirements**
       - Clarify error handling expectations and failure scenarios
       - Identify performance constraints and acceptable response times
       - Understand security implications and data protection requirements
       - Plan testing strategy and validation approaches
  </execution>

  <validation>
    - [ ] User experience expectations clearly defined
    - [ ] Core functionality requirements documented
    - [ ] Integration needs with existing systems understood
    - [ ] Configuration and default values specified
    - [ ] Error handling and failure scenarios planned
    - [ ] Performance and security constraints identified
    - [ ] Testing and validation strategy outlined
  </validation>

  <workflow>
    **Part of planning workflow:**
    - `/plan:init` - Initialize project or feature setup (optional)
    - `/plan:requirements` - Gather and clarify requirements (current)
    - `/research:codebase` - Understand existing patterns and constraints
    - `/research:external` - Research best practices and documentation
    - `/plan:synthesis` - Synthesize findings into implementation plan
    - `/plan:workflow` - Create detailed workflow for complex features

    **Prerequisites:** Clear feature or problem description
    **Next steps:** Research phase to gather technical information
    **Critical for:** Avoiding scope creep and ensuring complete understanding
  </workflow>

  <examples>
    ```bash
    # Gather requirements for new feature
    /plan:requirements "user authentication system"

    # Process: UX questions → technical needs → quality requirements
    # Result: Comprehensive requirements document with clear specifications
    ```

    ```bash
    # Example: E-commerce checkout requirements
    /plan:requirements "checkout flow redesign"

    # Process includes:
    # - UX: What payment methods? Guest checkout? Multi-step vs single page?
    # - Technical: Payment gateway integration? Tax calculation? Inventory checks?
    # - Quality: Error handling for payment failures? Performance under load?
    # - Result: Detailed requirements covering all aspects of checkout redesign
    ```

  </examples>
</instructions>
