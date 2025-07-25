# Security Audit Command

Perform comprehensive security assessment combining automated scanning and manual audit techniques.

## Usage

```
/security-audit <scope>
```

## Instructions

You are helping conduct a thorough security assessment. **Adhere to the guidelines specified below in your assessment.** Follow these steps:

1. **Assess security architecture and scope** including authentication, data handling, attack surfaces, and current controls

2. **Perform comprehensive security analysis** through automated scanning, manual testing, static analysis, and vulnerability assessment

3. **Generate detailed security report** with categorized findings, remediation recommendations, and prioritized action plan

## Guidelines

### **Assessment Coverage:**

- Injection vulnerabilities (SQL, NoSQL, OS, LDAP)
- Authentication, authorization, and session management
- Input validation, output encoding, and data exposure
- Cryptographic implementations and key management
- API security, rate limiting, and access controls
- Infrastructure security and vulnerable dependencies

### **Testing Methods:**

- Static analysis (SAST), dynamic testing (DAST), manual penetration testing
- Dependency scanning and configuration review
- OWASP Top 10 validation and attack vector testing

### **Risk Classification:**

- **Critical:** Remote code execution, data breach, authentication bypass
- **High:** Privilege escalation, sensitive data access, denial of service
- **Medium:** Information disclosure, input validation, session hijacking
- **Low:** Missing security headers, weak cryptography, verbose errors

## Prerequisites

- Access to codebase and security testing tools
- Understanding of security frameworks and common vulnerabilities
- Knowledge of OWASP Top 10 and security best practices

## Examples

```bash
# Assess entire application security
/security-audit "web application security posture"

# Focus on authentication system
/security-audit "user authentication and session management"

# Assess API security
/security-audit "REST API endpoints and data access"

# Evaluate payment system security
/security-audit "payment processing security"
```

## Next Steps

After assessment, use `/compliance-check` for regulatory compliance or `/threat-model` for architectural threat modeling.
