# Validate security implementation and identify vulnerabilities

<instructions>
  <context>
    Validate security implementation for $ARGUMENTS by conducting security analysis, vulnerability scanning, and compliance checking to ensure robust security posture.
  </context>

  <requirements>
    - Access to codebase and security scanning tools
    - Understanding of security best practices and common vulnerabilities
    - Knowledge of compliance requirements and security standards
  </requirements>

  <execution>
    1. **Quick analysis: Security validation scope and methodology**
       - Analyze $ARGUMENTS security area and identify comprehensive validation strategy
       - Plan security testing areas: vulnerabilities, authentication, authorization, data protection
       - Determine optimal security validation sequence for thorough assessment

    2. **Security analysis and scanning**
       - Scan code for security vulnerabilities and anti-patterns
       - Analyze input validation and sanitization implementations
       - Review authentication and authorization mechanisms
       - Check for secrets exposure and credential management

    3. **Vulnerability assessment**
       - Test for common vulnerabilities (OWASP Top 10)
       - Validate SQL injection and XSS protection
       - Check for insecure direct object references
       - Analyze session management and token security
       - Review API security and rate limiting
       - Test error handling for information disclosure

    4. **Compliance and best practices**
       - Validate against security standards and compliance requirements
       - Check encryption implementation and key management
       - Review logging and monitoring for security events
       - Analyze access controls and privilege escalation risks
       - Validate secure coding practices and patterns
       - Document security findings and remediation steps
  </execution>

  <validation>
    - [ ] Code scanned for security vulnerabilities and anti-patterns
    - [ ] Input validation and sanitization verified
    - [ ] Authentication and authorization mechanisms validated
    - [ ] Common vulnerabilities (OWASP Top 10) tested
    - [ ] API security and rate limiting verified
    - [ ] Encryption and key management reviewed
    - [ ] Security findings documented with remediation steps
  </validation>

  <workflow>
    **Part of validation workflow:**
    - `/validate:code` - Automated quality checks before security validation
    - `/validate:tests` - Ensure tests pass before security testing
    - `/validate:security` - Security validation and vulnerability testing (current)
    - `/security:scan` - Automated security scanning for additional coverage
    - `/security:audit` - Manual security assessment if needed

    **Prerequisites:** Feature implementation complete, basic validation passed
    **Next steps:** Address security findings, continue with other validation
    **Best practices:** Run for all user-facing features and API endpoints
  </workflow>

  <examples>
    ```bash
    # Validate authentication security
    /validate:security "user authentication and session management"

    # Process: scan code → test vulnerabilities → check compliance → document findings
    # Result: Security assessment report with vulnerability findings and fixes
    ```

    ```bash
    # Comprehensive API security validation
    /validate:security "REST API endpoints and data access"

    # Process includes:
    # - Scan API endpoints for injection vulnerabilities
    # - Test authentication bypass and privilege escalation
    # - Validate input sanitization and output encoding
    # - Check rate limiting and DDoS protection
    # - Review API documentation for security gaps
    # - Test error responses for information leakage
    ```
  </examples>
</instructions>