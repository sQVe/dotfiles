# Investigate production issues using Sentry

<instructions>
  <context>
    Investigate production issues for $ARGUMENTS using Sentry MCP to analyze error patterns, user impact, and system behavior.
  </context>

  <requirements>
    - Production issue description or error pattern to investigate
    - Access to Sentry MCP for production error analysis
    - Understanding of system architecture and deployment environments
  </requirements>

  <execution>
    1. **Ultrathink: Production issue investigation strategy**
       - Use sequential thinking to analyze $ARGUMENTS production context and plan investigation approach
       - Break down investigation areas: error patterns, user impact, timing correlation, system health
       - Consider investigation tools: Sentry analysis, deployment correlation, dependency tracking
       - Plan investigation sequence focusing on business impact and root cause identification

    2. **Discover errors and analyze impact**
       - Use Sentry MCP to find and analyze production errors related to $ARGUMENTS
       - Identify error frequency trends, patterns, and affected user segments
       - Assess business impact and urgency based on error scope

    3. **Investigate error patterns and root causes**
       - Analyze stack traces and execution context for debugging
       - Use Sentry's AI-powered analysis to identify potential root causes
       - Group related errors to understand common underlying issues
       - Investigate correlation with recent deployments or configuration changes
       - Examine dependency failures and external service impacts

    4. **Report findings and recommend actions**
       - Document findings with specific error rates, user impact, and timelines
       - Provide clear root cause analysis with supporting evidence
       - Recommend immediate mitigation strategies and long-term fixes
       - Suggest monitoring improvements to detect similar issues earlier
  </execution>

  <validation>
    - [ ] Production error patterns analyzed using Sentry MCP
    - [ ] User impact quantified with specific metrics
    - [ ] Root cause analysis completed with supporting evidence
    - [ ] Correlation with deployments investigated
    - [ ] Findings documented with error rates and timelines
    - [ ] Mitigation strategies recommended
  </validation>

  <workflow>
    **Production debugging workflow:**
    - `/debug:production` - Investigate production issues using Sentry (current)
    - `/debug:analyze` - Deep analysis if root cause needs further investigation
    - `/implement:resolve` - Implement immediate fixes for critical issues

    **Prerequisites:** Production errors or performance degradation observed
    **Next steps:** Immediate mitigation or emergency response based on findings
    **Best for:** Production-specific issues, deployment-related problems, user impact analysis
  </workflow>

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
