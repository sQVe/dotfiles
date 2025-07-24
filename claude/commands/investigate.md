# Investigate Command

Investigate complex technical problems through systematic analysis and evidence gathering.

## Usage
```
/investigate <issue-description>
```

## Instructions
You are helping investigate a technical problem systematically. Follow these steps:

1. **Analyze issue and gather evidence** including symptoms, logs, diagnostic information, and environmental context

2. **Investigate root cause** through systematic hypothesis testing, timeline reconstruction, and correlation analysis

3. **Document findings and solutions** with specific remediation steps, evidence summary, and prevention measures

## Prerequisites
- Access to logs, monitoring tools, and system diagnostics
- Understanding of system architecture and common failure patterns
- Ability to correlate events across multiple data sources

## Examples
```bash
# Investigate database connection issues
/investigate "database connection timeouts in production"

# Debug authentication failures with log analysis
/investigate "authentication failures after v2.1 deployment"

# Investigate API performance degradation
/investigate "API response time degradation last 24 hours"

# Debug session management problems
/investigate "users randomly logged out during active sessions"
```

## Next Steps
After investigation, use `/reproduce` to confirm fixes or `/profile` for performance-specific issues.
