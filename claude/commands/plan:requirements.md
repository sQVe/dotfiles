# Gather and clarify requirements through systematic questioning

<instructions>
  <context>
    Systematically gather and clarify requirements for $ARGUMENTS through targeted questions and analysis to ensure complete understanding before implementation.
  </context>

  <requirements>
    - Clear feature or problem description to analyze
    - Understanding of project context and user needs
    - Access to stakeholders or requirement sources
  </requirements>

  <execution>
    1. **Validate and gather user experience requirements**
       - Verify $ARGUMENTS is provided (feature/problem to analyze required)
       - If no argument provided, show error: "Please specify what to analyze (e.g., 'user authentication', 'checkout flow')"
       - Ask clarifying questions about exact user experience expectations
       - Determine core functionality vs nice-to-have features
       - Understand user workflows and interaction patterns
       - Identify accessibility and usability requirements

    2. **Technical and integration requirements**
       - Determine configuration needs and sensible default values
       - Understand integration requirements with existing features
       - Identify data storage and persistence needs
       - Clarify API and external service dependencies

    3. **Quality and operational requirements**
       - Clarify error handling expectations and failure scenarios
       - Identify performance constraints, SLAs, and acceptable response times
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
