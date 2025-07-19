# Conduct comprehensive security audit and assessment

<instructions>
  <context>
    Conduct comprehensive security audit for $ARGUMENTS including manual review, automated testing, and compliance assessment to evaluate overall security posture.
  </context>

  <requirements>
    - Access to complete system architecture and documentation
    - Understanding of security frameworks and compliance standards
    - Ability to perform manual security testing and code review
  </requirements>

  <execution>
    1. **Ultrathink: Security audit strategy and methodology**
       - Use sequential thinking to analyze $ARGUMENTS security scope and plan comprehensive audit approach
       - Break down audit areas: architecture review, vulnerability assessment, compliance evaluation, governance analysis
       - Consider audit methodologies: threat modeling, penetration testing, code review, policy assessment, compliance mapping
       - Plan systematic audit sequence ensuring thorough coverage and risk-based prioritization

    2. **Security architecture review**
       - Review system architecture and security design
       - Analyze authentication and authorization mechanisms
       - Examine data flow and trust boundaries
       - Assess security controls and defensive measures

    3. **Manual security testing and analysis**
       - Perform manual penetration testing and vulnerability assessment
       - Test business logic flaws and application-specific vulnerabilities
       - Analyze session management and state handling
       - Review error handling and information disclosure
       - Test privilege escalation and access control bypasses
       - Examine cryptographic implementations and key management

    4. **Compliance and governance assessment**
       - Assess compliance with relevant security standards (OWASP, NIST, etc.)
       - Review security policies and procedures
       - Evaluate incident response and security monitoring capabilities
       - Analyze security training and awareness programs
       - Document security gaps and improvement recommendations
       - Create comprehensive security audit report
  </execution>

  <validation>
    - [ ] Security architecture and design reviewed
    - [ ] Manual penetration testing completed
    - [ ] Business logic and application-specific vulnerabilities tested
    - [ ] Compliance with security standards assessed
    - [ ] Security policies and procedures evaluated
    - [ ] Comprehensive audit report with recommendations created
  </validation>

  <workflow>
    **Part of security workflow:**
    - `/security:threat-model` - Design-time threat analysis (recommended first)
    - `/security:scan` - Automated vulnerability detection before audit
    - `/security:audit` - Comprehensive manual security assessment (current)
    - `/security:compliance` - Regulatory compliance validation

    **Prerequisites:** System deployed and accessible, security scanning completed
    **Next steps:** Address findings, implement security controls, validate compliance
    **Best timing:** Before major releases, quarterly security reviews
  </workflow>

  <examples>
    ```bash
    # Full application security audit
    /security:audit "web application security posture"

    # Process: architecture review → manual testing → compliance assessment → report
    # Result: Comprehensive security audit with detailed findings and recommendations
    ```

    ```bash
    # API-focused security audit
    /security:audit "REST API security and access controls"

    # Process includes:
    # - Review API authentication and authorization design
    # - Test API endpoints for injection and bypass vulnerabilities
    # - Analyze rate limiting and DDoS protection
    # - Examine API documentation for security gaps
    # - Test error handling and information leakage
    # - Assess API versioning and deprecation security
    ```
  </examples>
</instructions>