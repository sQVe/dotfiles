# Threat Model Command

Create comprehensive threat model to identify potential threats, attack vectors, and security risks with mitigation strategies.

## Usage

```
/threat-model <system-or-component>
```

## Instructions

You are helping create a structured threat model for a system or component. **Adhere to the guidelines specified below in your modeling.** Follow these steps:

1. **Decompose system architecture** by mapping components, data flows, trust boundaries, and critical assets

2. **Identify threats and attack scenarios** using STRIDE methodology and risk assessment

3. **Design mitigation strategies** with prioritized security controls and monitoring requirements

## Guidelines

### **STRIDE Analysis:**

- **Spoofing:** Identity bypass, credential theft, impersonation
- **Tampering:** Data integrity compromise, unauthorized modifications
- **Repudiation:** Audit trail gaps, non-repudiation controls
- **Information Disclosure:** Unauthorized access, data leakage
- **Denial of Service:** Availability disruption, resource exhaustion
- **Elevation of Privilege:** Access escalation, authorization bypass

### **System Elements:**

- Assets, entry points, trust boundaries, data flows, external dependencies
- Authentication mechanisms, access controls, data storage/transmission
- APIs, user interfaces, network services, third-party integrations

### **Risk Assessment:**

- **Critical (High/High):** Authentication bypass, data exposure - immediate mitigation
- **High (High/Medium):** Privilege escalation, service disruption - prompt attention
- **Medium (Medium/High):** Injection attacks, weak encryption - planned remediation
- **Low:** Information disclosure, missing headers - monitoring

### **Controls:**

- **Preventive:** Input validation, authentication, authorization, encryption
- **Detective:** Monitoring, logging, intrusion detection
- **Corrective:** Incident response, automated remediation, failover

## Examples

```bash
# Model authentication system threats
/threat-model "user authentication and session management"

# Model API security threats
/threat-model "REST API for financial transactions"

# Model data processing threats
/threat-model "customer data processing pipeline"
```
