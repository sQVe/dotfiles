# Threat Model Command

Execute proactive threat modeling during design phase to identify potential threats, attack vectors, and security risks before implementation.

## Usage

```
/threat-model <system-or-component>
```

## Instructions

You are helping create a structured threat model for defensive security purposes.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Decompose system architecture and assets**
   - Map system components, services, and infrastructure elements
   - Identify data flows, communication channels, and integration points
   - Define trust boundaries between internal and external systems
   - Catalog critical assets: data, processes, and system components

3. **Identify entry points and attack surface**
   - Document user interfaces, APIs, and network services
   - Map authentication mechanisms and access control points
   - Identify external dependencies and third-party integrations
   - Analyze data storage locations and transmission paths

4. **Apply STRIDE threat analysis**
   - **Spoofing**: Identity bypass, credential theft, impersonation
   - **Tampering**: Data integrity compromise, unauthorized modifications, code injection
   - **Repudiation**: Audit trail gaps, non-repudiation controls, logging weaknesses
   - **Information Disclosure**: Unauthorized access, data leakage, privilege escalation
   - **Denial of Service**: Availability disruption, resource exhaustion, system overload
   - **Elevation of Privilege**: Access escalation, authorization bypass, privilege abuse

5. **Assess risk and impact levels**
   - Evaluate threat likelihood based on attack complexity and attacker motivation
   - Assess potential impact on confidentiality, integrity, and availability
   - Calculate risk scores using likelihood and impact matrices
   - Prioritize threats based on business impact and exploitability

6. **Design comprehensive mitigation strategies**
   - **Preventive controls**: Input validation, authentication, authorization, encryption
   - **Detective controls**: Monitoring, logging, intrusion detection, anomaly detection
   - **Corrective controls**: Incident response, automated remediation, failover
   - **Compensating controls**: Additional safeguards when primary controls insufficient

7. **Generate comprehensive threat model report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include threat scenarios: Attack vectors and exploitation methods
   - Document system diagrams: Architecture maps with trust boundaries and data flows
   - Provide mitigation roadmap: Prioritized security controls and implementation timeline
   - Add monitoring requirements: Detection strategies and security metrics

## Examples

```bash
# Model authentication system threats during design
/threat-model "user authentication and session management"

# Model API security threats before implementation
/threat-model "REST API for financial transactions"

# Model data processing threats for new pipeline
/threat-model "customer data processing pipeline"

# Follow up with security audit after implementation
# /security-audit "implemented payment system"
```
