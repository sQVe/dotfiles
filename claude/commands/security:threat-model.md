# Create comprehensive threat model and risk assessment

<instructions>
  <context>
    Create comprehensive threat model for $ARGUMENTS to identify potential threats, attack vectors, and security risks, with corresponding mitigation strategies.
  </context>

  <requirements>
    - Understanding of system architecture and data flows
    - Knowledge of threat modeling methodologies (STRIDE, PASTA, etc.)
    - Access to system documentation and stakeholder input
  </requirements>

  <execution>
    1. **Ultrathink: Threat modeling strategy and methodology selection**
       - Use sequential thinking to analyze $ARGUMENTS threat modeling scope and plan comprehensive risk assessment approach
       - Break down threat modeling elements: system decomposition, threat identification, risk assessment, mitigation planning
       - Consider threat modeling methodologies: STRIDE, PASTA, OCTAVE, attack trees, data flow diagrams
       - Plan systematic threat modeling sequence ensuring comprehensive coverage and actionable security improvements

    2. **System decomposition and analysis**
       - Verify $ARGUMENTS is provided (system or feature to model required)
       - If no argument provided, show error: "Please specify system to threat model (e.g., 'user authentication system')"
       - Decompose system into components and data flows
       - Identify assets, entry points, and trust boundaries
       - Map user roles, permissions, and access patterns
       - Document system dependencies and external interfaces

    3. **Threat identification and analysis**
       - Apply threat modeling methodology (STRIDE recommended)
       - Identify potential threats for each system component
       - Analyze attack vectors and exploitation scenarios
       - Assess threat actor capabilities and motivations
       - Evaluate impact and likelihood of identified threats
       - Document threat scenarios with attack trees

    4. **Risk assessment and mitigation planning**
       - Calculate risk scores based on impact and likelihood
       - Prioritize threats based on risk assessment
       - Identify existing security controls and their effectiveness
       - Design mitigation strategies for high-priority threats
       - Plan security controls implementation roadmap
       - Create threat model documentation and review process
  </execution>

  <validation>
    - [ ] System decomposed into components and data flows
    - [ ] Assets, entry points, and trust boundaries identified
    - [ ] Threats identified using systematic methodology
    - [ ] Attack vectors and exploitation scenarios documented
    - [ ] Risk scores calculated and threats prioritized
    - [ ] Mitigation strategies designed for high-priority threats
    - [ ] Comprehensive threat model documentation created
  </validation>

  <workflow>
    **Part of security workflow:**
    - `/security:threat-model` - Proactive threat analysis during design (current)
    - `/security:scan` - Validate threat mitigations with automated scanning
    - `/security:audit` - Manual verification of threat model assumptions
    - `/security:compliance` - Ensure threat mitigations meet regulatory requirements

    **Prerequisites:** System architecture understanding (use `/research:codebase` first)
    **Next steps:** Implement security controls, validate with `/security:scan`
    **Best timing:** During feature design, architecture changes, new system planning
  </workflow>

  <examples>
    ```bash
    # Threat model for authentication system
    /security:threat-model "user authentication and session management"

    # Process: decompose → identify threats → assess risk → plan mitigations → document
    # Result: Comprehensive threat model with prioritized risks and mitigation strategies
    ```

    ```bash
    # API threat modeling
    /security:threat-model "REST API for financial transactions"

    # Process includes:
    # - Map API endpoints, data flows, and external integrations
    # - Identify threats: injection, broken auth, data exposure, etc.
    # - Analyze attack scenarios: credential stuffing, API abuse, data theft
    # - Assess financial and compliance impact of successful attacks
    # - Design API security controls and monitoring strategies
    # - Create threat model with security requirements
    ```
  </examples>
</instructions>