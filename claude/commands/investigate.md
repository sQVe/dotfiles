# Investigate Command

Perform systematic investigation of complex technical problems through evidence gathering and root cause analysis.

## Usage

```
/investigate <issue-description>
```

## Instructions

You are helping investigate a technical problem through systematic analysis and evidence gathering.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Strategic investigation analysis**
   - Use ultrathink analysis to form testable hypotheses about root causes, guiding all subsequent steps
   - Map symptom patterns to system components and recent changes
   - Prioritize investigation paths by likelihood and evidence availability

3. **Define investigation scope and context**
   - Understand the reported issue symptoms and impact
   - Identify affected systems, users, and timeframes
   - Gather initial context about recent changes, deployments, or configuration updates

4. **Collect evidence and diagnostic data**
   - **System logs**: Review application, error, and system logs for relevant timeframes
   - **Monitoring data**: Analyze metrics, performance data, health check results
   - **Environment analysis**: Check config files, environment variables, system state
   - **User reports**: Gather symptoms, reproduction steps, user impact details

5. **Analyze patterns and correlations**
   - **Timeline reconstruction**: Map events chronologically to identify triggers
   - **Pattern identification**: Look for recurring errors, anomalies, behavioral changes
   - **Correlation analysis**: Connect symptoms across system components
   - **Hypothesis formation**: Develop testable theories about root causes

6. **Test hypotheses and validate findings**
   - **Reproduce issues**: Attempt to recreate the problem in controlled environments
   - **Isolate variables**: Test individual components to narrow down the root cause
   - **Verify fixes**: Test potential solutions against the identified root cause

7. **Generate comprehensive investigation report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include evidence summary: Key logs, metrics, diagnostic data supporting conclusions
   - Document root cause: Specific technical explanation of what caused the issue
   - Provide remediation steps: Immediate fixes and long-term prevention measures
   - Add timeline: Chronological sequence of events during the incident

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
