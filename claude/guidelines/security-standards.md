# Security standards

### Data protection

- **Never store secrets in code**: No API keys, passwords, or sensitive data in commits. Use environment variables and secure storage.
- **Encrypt sensitive data**: At rest and in transit. Use proven encryption libraries, never implement custom cryptography.
- **Minimize data collection**: Only collect and store data that is essential for functionality.
- **Sanitize logs**: Never log passwords, tokens, personal data, or other sensitive information.

### Input validation and handling

- **Validate and sanitize all inputs**: Never trust external user input. Validate types, ranges, formats, and sanitize before processing.
- **Use parameterized queries**: Prevent SQL injection with prepared statements and parameterized queries.
- **Avoid dynamic code execution**: Never use eval() or execute user-provided code as code.
- **Implement proper file upload controls**: Validate file types, sizes, and scan for malicious content.

### Authentication and authorization

- **Validate permissions on every request**: Never trust client-side authorization. Always verify server-side.
- **Implement session management**: Use secure session tokens with proper expiration and regeneration.
- **Use multi-factor authentication**: For administrative and sensitive operations.
- **Follow password best practices**: Enforce strong passwords and use secure hashing (bcrypt, scrypt, argon2).

### Infrastructure security

- **Use HTTPS everywhere**: Encrypt all data in transit with TLS 1.2 or higher.
- **Implement security headers**: Use CSP, HSTS, X-Frame-Options, and other protective headers.
- **Apply rate limiting**: Protect APIs from abuse with appropriate throttling and quotas.
- **Keep dependencies updated**: Regularly update libraries and frameworks to patch vulnerabilities.

### Error handling and monitoring

- **Fail securely**: Errors should not leak sensitive information about system internals or data.
- **Log security events**: Monitor authentication failures, authorization violations, and suspicious activity.
- **Implement alerting**: Set up notifications for security-relevant events and anomalies.
- **Plan incident response**: Have procedures for handling security incidents and breaches.

### Development practices

- **Treat external user input as potentially hostile**: Design with the assumption that every input is a potential attack vector.
- **Follow principle of least privilege**: Grant minimal necessary permissions to users and systems.
- **Conduct security reviews**: Review code for security issues before deployment.
- **Test security controls**: Include security testing in your testing strategy.
