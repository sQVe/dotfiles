# Security Audit Command

Perform comprehensive security assessment of existing systems combining automated scanning and manual audit techniques to identify actual vulnerabilities.

## Usage

```
/security-audit <scope>
```

## Instructions

You are helping conduct a thorough security assessment for defensive purposes only.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Strategic security audit analysis**
   - Use ultrathink analysis to map attack surface and identify high-risk components, guiding all subsequent steps
   - Prioritize assessment areas by threat exposure: public endpoints, privileged access, sensitive data
   - Focus on exploitable vulnerabilities that could lead to actual security breaches

3. **Define security audit scope and baseline**
   - Identify systems, applications, and components to assess
   - Understand current security controls and architecture
   - Gather existing security documentation and previous audit reports
   - Establish security requirements and compliance standards

4. **Execute automated security scanning**
   - **Static analysis (SAST)**: Scan source code for vulnerabilities and coding flaws
   - **Dependency scanning**: Check for known vulnerabilities in third-party libraries
   - **Configuration analysis**: Review security configs, environment variables, deployment settings
   - **Infrastructure scanning**: Assess network security, server configs, cloud security posture

5. **Perform manual security analysis**
   - **Authentication and authorization**: Review access controls, session management, privilege escalation
   - **Input validation**: Analyze data sanitization, injection prevention, output encoding
   - **Cryptographic implementation**: Assess encryption usage, key management, secure protocols
   - **API security**: Evaluate endpoint security, rate limiting, authentication, data exposure

6. **Assess OWASP Top 10 vulnerabilities**
   - **Injection flaws**: SQL, NoSQL, OS command, LDAP injection
   - **Broken authentication**: Session management, credential storage, MFA
   - **Sensitive data exposure**: Encryption, secure transmission, data classification
   - **Security misconfiguration**: Default configs, unnecessary features, error handling
   - **Cross-site scripting (XSS)**: Input sanitization, output encoding, CSP

7. **Generate comprehensive security report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include vulnerability details: Locations, attack vectors, potential impact
   - Document security gaps: Missing controls, config weaknesses, architectural flaws
   - Provide remediation guidance: Specific fixes, security controls, implementation recommendations
   - Add compliance assessment: Alignment with security standards and regulatory requirements

## Examples

```bash
# Assess entire application security posture
/security-audit "web application security posture"

# Audit implemented authentication system
/security-audit "user authentication and session management"

# Validate API security implementation
/security-audit "REST API endpoints and data access"

# Preceded by threat modeling during design phase
# /threat-model "new payment API architecture"
```
