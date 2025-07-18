# Investigate production errors and performance issues using Sentry

<instructions>
  <context>
    Investigate production issues for $ARGUMENTS using Sentry MCP to analyze error patterns, user impact, and system behavior in live environments.
  </context>

  <requirements>
    - Production issue description or error pattern to investigate
    - Access to Sentry MCP for production error analysis
    - Understanding of system architecture and deployment environments
    - Access to monitoring dashboards and performance metrics
  </requirements>

  <execution>
    1. **Production error discovery and impact analysis**
       - Verify $ARGUMENTS is provided (production issue to investigate required)
       - If no argument provided, show error: "Please specify what to investigate (e.g., 'user login failures', 'payment processing errors')"
       - Use Sentry MCP to find and analyze production errors related to $ARGUMENTS
       - Identify error frequency trends, patterns, and affected user segments
       - Assess business impact and urgency based on error scope and affected functionality

    2. **Error pattern and root cause investigation**
       - Analyze detailed stack traces and execution context for debugging
       - Use Sentry's AI-powered analysis to identify potential root causes
       - Group related errors to understand common underlying issues
       - Investigate correlation with recent deployments or configuration changes
       - Examine dependency failures and external service impacts

    3. **Reporting and actionable recommendations**
       - Document findings with specific error rates, user impact, and timelines
       - Provide clear root cause analysis with supporting evidence from Sentry data
       - Recommend immediate mitigation strategies and long-term fixes
       - Suggest monitoring improvements to detect similar issues earlier
       - Create action items for preventing recurrence of similar problems

  </execution>

  <validation>
    - [ ] Production error patterns analyzed using Sentry MCP for specified issue
    - [ ] User impact and scope clearly quantified with specific metrics
    - [ ] Root cause analysis completed with supporting evidence from Sentry
    - [ ] Correlation with deployments and configuration changes investigated
    - [ ] Business impact assessment completed with urgency evaluation
    - [ ] Clear findings documented with specific error rates and timelines
    - [ ] Immediate mitigation strategies recommended with implementation guidance
  </validation>

  <examples>
    ```bash
    # Investigate authentication production errors
    /debug:production "user login failures"

    # Process: Sentry error analysis → impact assessment → root cause investigation → recommendations
    # Result: Production issue analysis with concrete mitigation strategies and monitoring improvements
    ```

    ```bash
    # Investigate performance degradation after deployment
    /debug:production "API response time increase after latest deployment"

    # Process includes:
    # - Sentry error analysis revealing database timeout patterns
    # - Correlation with specific deployment version identification
    # - User impact assessment across different API endpoints
    # - Root cause identification with immediate rollback recommendation
    # - Long-term optimization plan with monitoring improvements
    ```

  </examples>
</instructions>
