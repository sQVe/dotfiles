# Compliance Check Command

Assess security compliance against relevant standards, regulations, and industry best practices.

## Usage
```
/compliance-check <compliance-framework>
```

## Instructions
You are helping assess compliance with security and regulatory requirements. Follow these steps:

1. **Assess compliance scope** by identifying applicable frameworks and reviewing current controls

2. **Analyze compliance gaps** through documentation review and control evaluation

3. **Create remediation roadmap** with prioritized action plans and implementation guidance

## Guidelines

### **Framework Requirements:**
- **GDPR:** Lawful processing basis, data subject rights, privacy by design, 72-hour breach notification, DPIA for high-risk processing
- **SOC 2:** Access controls, system availability, data integrity, confidentiality measures, privacy management
- **PCI DSS:** Secure network architecture, access controls, monitoring, policy maintenance, quarterly validation
- **ISO 27001:** ISMS establishment, risk assessment, policy documentation, incident management, audit processes

### **Evidence Collection:**
- Policy documentation with version control
- Technical configurations and audit logs
- Training records and vulnerability reports
- Third-party attestations and certifications

## Examples
```bash
# Assess GDPR data protection compliance
/compliance-check "GDPR data protection compliance"

# Evaluate SOC 2 security controls
/compliance-check "SOC 2 Type II security controls"

# Check PCI DSS payment security compliance
/compliance-check "PCI DSS payment card security"
```
