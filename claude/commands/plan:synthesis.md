# Synthesize research findings into actionable implementation plan

<instructions>
  <context>
    Synthesize research findings and requirements for $ARGUMENTS into actionable implementation guidance with clear decisions and trade-offs.
  </context>

  <requirements>
    - Completed research (external docs, codebase patterns, requirements)
    - Understanding of project constraints and goals
    - Ability to evaluate trade-offs and make technical decisions
  </requirements>

  <execution>
    1. **Validate and consolidate findings**
       - Verify $ARGUMENTS is provided (topic to synthesize required)
       - If no argument provided, show error: "Please specify what to synthesize (e.g., 'payment integration plan')"
       - Review and consolidate research from external documentation
       - Integrate codebase pattern analysis and existing conventions
       - Combine requirement gathering results and constraints
       - Identify any gaps or conflicting information

    2. **Decision and trade-off analysis**
       - Evaluate different implementation approaches and their trade-offs
       - Make specific technical decisions based on research findings
       - Document rationale for chosen approaches over alternatives
       - Consider long-term maintainability and scalability implications

    3. **Implementation roadmap creation**
       - Create step-by-step implementation guidance
       - Identify potential risks and mitigation strategies
       - Prepare reference list of useful documentation and examples
       - Define success criteria and validation approaches
  </execution>

  <validation>
    - [ ] All research findings reviewed and consolidated
    - [ ] Technical decisions made with clear rationale
    - [ ] Trade-offs between approaches documented
    - [ ] Implementation roadmap with specific steps created
    - [ ] Potential risks and mitigation strategies identified
    - [ ] Success criteria and validation approaches defined
  </validation>

  <examples>
    ```bash
    # Synthesize authentication implementation plan
    /plan:synthesis "user authentication system"

    # Process: consolidate research → make decisions → create roadmap
    # Result: Complete implementation plan with decisions, steps, and trade-offs
    ```

    ```bash
    # Example: Payment integration synthesis
    /plan:synthesis "payment processing integration"

    # Process includes:
    # - Consolidate: External API docs + codebase patterns + requirements
    # - Decide: Stripe vs PayPal, webhook vs polling, error handling approach
    # - Plan: Step-by-step implementation with security considerations
    # - Result: Detailed roadmap with chosen approach and justification
    ```
  </examples>
</instructions>