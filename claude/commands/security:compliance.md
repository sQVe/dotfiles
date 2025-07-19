# Assess security compliance and regulatory adherence

<instructions>
  <context>
    Assess security compliance for $ARGUMENTS against relevant standards, regulations, and industry best practices to ensure regulatory adherence and risk management.
  </context>

  <requirements>
    - Understanding of applicable compliance frameworks and regulations
    - Access to system documentation and security policies
    - Knowledge of compliance assessment methodologies
  </requirements>

  <execution>
    1. **Ultrathink: Compliance assessment strategy and framework analysis**
       - Use sequential thinking to analyze $ARGUMENTS compliance scope and plan comprehensive assessment approach
       - Break down compliance areas: regulatory requirements, gap analysis, control assessment, documentation review, remediation planning
       - Consider compliance methodologies: framework mapping, control testing, evidence collection, risk assessment, continuous monitoring
       - Plan systematic compliance evaluation sequence ensuring thorough coverage and regulatory alignment

    2. **Compliance framework identification**
       - Verify $ARGUMENTS is provided (compliance standard or system area required)
       - If no argument provided, show error: "Please specify compliance scope (e.g., 'GDPR compliance' or 'SOC 2 Type II')"
       - Identify applicable compliance frameworks and regulations
       - Map business requirements to compliance standards
       - Review industry-specific compliance requirements
       - Document compliance scope and assessment criteria

    3. **Compliance gap analysis**
       - Assess current implementation against compliance requirements
       - Identify gaps in security controls and documentation
       - Review data handling and privacy protection measures
       - Analyze access controls and audit logging compliance
       - Examine incident response and breach notification procedures
       - Evaluate vendor and third-party compliance requirements

    4. **Remediation planning and documentation**
       - Prioritize compliance gaps based on risk and regulatory impact
       - Create remediation plans with timelines and responsibilities
       - Design compliance monitoring and continuous assessment processes
       - Prepare compliance documentation and evidence collection
       - Plan compliance training and awareness programs
       - Create compliance assessment report with recommendations
  </execution>

  <validation>
    - [ ] Applicable compliance frameworks identified and mapped
    - [ ] Current implementation assessed against requirements
    - [ ] Compliance gaps identified and documented
    - [ ] Data handling and privacy protection measures reviewed
    - [ ] Remediation plans created with timelines
    - [ ] Compliance monitoring processes designed
    - [ ] Comprehensive compliance report generated
  </validation>

  <workflow>
    **Compliance assessment workflow:**
    - `/security:scan` - Automated security vulnerability detection first
    - `/security:audit` - Comprehensive security control review
    - `/security:compliance` - Regulatory and framework compliance assessment (current)
    - `/plan:improvements` - Create compliance remediation plan
    - `/implement:resolve` - Address compliance gaps and issues

    **Prerequisites:** Security assessment completed, compliance requirements understood
    **Next steps:** Compliance gap remediation and ongoing monitoring
    **Complements:** `/security:audit` for security controls, `/security:threat-model` for risk analysis
  </workflow>

  <examples>
    ```bash
    # GDPR compliance assessment
    /security:compliance "GDPR data protection compliance"

    # Process: identify requirements → assess gaps → plan remediation → document
    # Result: GDPR compliance assessment with gap analysis and remediation roadmap
    ```

    ```bash
    # SOC 2 compliance assessment
    /security:compliance "SOC 2 Type II security controls"

    # Process includes:
    # - Map SOC 2 trust service criteria to current controls
    # - Assess security, availability, and confidentiality controls
    # - Review access controls and monitoring capabilities
    # - Examine change management and incident response
    # - Evaluate vendor management and third-party risks
    # - Prepare evidence collection and audit readiness plan
    ```
  </examples>
</instructions>