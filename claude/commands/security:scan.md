# Perform comprehensive security scanning and vulnerability detection

<instructions>
  <context>
    Perform comprehensive security scanning for $ARGUMENTS to identify vulnerabilities, security anti-patterns, and potential attack vectors across the codebase and infrastructure.
  </context>

  <requirements>
    - Access to security scanning tools and vulnerability databases
    - Understanding of common security vulnerabilities and attack patterns
    - Ability to analyze code, dependencies, and configuration files
  </requirements>

  <execution>
    1. **Static code security analysis**
       - Verify $ARGUMENTS is provided (scan scope or specific area required)
       - If no argument provided, show error: "Please specify security scan scope (e.g., 'entire codebase' or 'authentication module')"
       - Scan source code for security vulnerabilities and anti-patterns
       - Analyze input validation and output encoding practices
       - Check for hardcoded secrets, credentials, and sensitive data
       - Identify insecure cryptographic implementations

    2. **Dependency and infrastructure scanning**
       - Scan dependencies for known security vulnerabilities
       - Check for outdated packages with security patches
       - Analyze container images and infrastructure configurations
       - Review environment variables and configuration security
       - Scan for exposed services and insecure network configurations
       - Check SSL/TLS configurations and certificate validity

    3. **Vulnerability assessment and prioritization**
       - Categorize vulnerabilities by severity and exploitability
       - Assess potential impact and attack vectors
       - Prioritize findings based on risk assessment
       - Generate remediation recommendations and timelines
       - Document false positives and accepted risks
       - Create security scan report with actionable findings
  </execution>

  <validation>
    - [ ] Static code analysis completed for specified scope
    - [ ] Dependencies scanned for known vulnerabilities
    - [ ] Infrastructure and configuration security reviewed
    - [ ] Vulnerabilities categorized by severity and impact
    - [ ] Remediation recommendations provided with timelines
    - [ ] Security scan report generated with actionable findings
  </validation>

  <workflow>
    **Part of security workflow:**
    - `/security:threat-model` - Design-time threat analysis (optional, for new features)
    - `/security:scan` - Automated vulnerability detection (current)
    - `/security:audit` - Manual security testing and review
    - `/security:compliance` - Regulatory compliance assessment

    **Prerequisites:** Code to scan (can be run during development)
    **Next steps:** Address findings, run `/security:audit` for comprehensive review
    **Best practices:** Run regularly during development, before releases
  </workflow>

  <examples>
    ```bash
    # Comprehensive security scan
    /security:scan "entire application codebase"

    # Process: static analysis → dependency scan → infrastructure review → prioritize → report
    # Result: Complete security assessment with prioritized vulnerability findings
    ```

    ```bash
    # Focused security scan
    /security:scan "payment processing module"

    # Process includes:
    # - Deep analysis of payment-related code for PCI compliance
    # - Scan for injection vulnerabilities in payment flows
    # - Review encryption and key management practices
    # - Check for sensitive data exposure in logs and errors
    # - Validate input sanitization and output encoding
    # - Generate compliance-focused security report
    ```
  </examples>
</instructions>