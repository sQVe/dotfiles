# Debug through comprehensive log analysis

<instructions>
  <context>
    Analyze logs for $ARGUMENTS through systematic parsing, pattern identification, and issue correlation to identify debugging insights.
  </context>

  <requirements>
    - Access to relevant log files and logging systems
    - Understanding of log formats and application architecture
    - Knowledge of debugging methodologies and pattern analysis
    - Ability to correlate events across multiple log sources
  </requirements>

  <execution>
    1. **Quick analysis: Log scope and comprehensive analysis strategy**
       - Analyze $ARGUMENTS context and identify relevant log sources
       - Plan analysis approach: error patterns, performance issues, timeline reconstruction
       - Determine optimal log parsing and correlation strategy

    2. **Log collection and parsing**
       - Identify and collect relevant log files and sources
       - Parse log formats and extract structured data
       - Filter logs by time range, severity, and relevance
       - Organize logs by source, component, and event type

    3. **Pattern analysis and issue identification**
       - Identify error patterns, exceptions, and failure modes
       - Analyze performance metrics and bottlenecks from logs
       - Reconstruct event timelines and user journeys
       - Correlate events across multiple services and components
       - Detect anomalies and unusual patterns

    4. **Root cause analysis and recommendations**
       - Synthesize findings into potential root causes
       - Provide evidence-based debugging recommendations
       - Suggest monitoring improvements and log enhancements
       - Document patterns for future debugging reference
  </execution>

  <validation>
    - [ ] Relevant log sources identified and collected
    - [ ] Log data parsed and structured appropriately
    - [ ] Error patterns and exceptions identified
    - [ ] Performance issues detected from log analysis
    - [ ] Event timelines reconstructed accurately
    - [ ] Cross-service correlations established
    - [ ] Root cause hypotheses developed with evidence
    - [ ] Actionable debugging recommendations provided
  </validation>

  <workflow>
    **Part of debugging workflow:**
    1. `/debug:analyze` - Initial problem analysis and hypothesis
    2. `/debug:logs` - Log analysis for evidence and patterns (current)
    3. `/debug:reproduce` - Attempt to reproduce issues found in logs
    4. `/debug:performance` - Performance analysis if bottlenecks identified
    5. `/implement:resolve` - Fix issues based on log analysis findings

    **Prerequisites:** Access to relevant logs, understanding of issue timeframe
    **Next steps:** Use findings to reproduce issues or implement fixes
    **Complements:** Other debug commands for comprehensive troubleshooting
  </workflow>

  <examples>
    ```bash
    # Analyze application errors from recent deployment
    /debug:logs "authentication failures after v2.1 deployment"

    # Process: identify logs → parse errors → correlate timeline → root cause analysis
    # Result: Specific error patterns and deployment correlation findings
    ```

    ```bash
    # Debug performance issues through log analysis
    /debug:logs "API response time degradation last 24 hours"

    # Process includes:
    # - Parse application and access logs for timing data
    # - Identify slow endpoints and database query patterns
    # - Correlate performance drops with specific events
    # - Analyze resource usage and bottleneck indicators
    # - Reconstruct user journey timelines
    # - Provide performance optimization recommendations
    ```

    ```bash
    # Example log analysis results
    # 🔍 Log Sources Analyzed:
    # - Application logs: 2.3M entries (last 6 hours)
    # - Access logs: 890K requests analyzed
    # - Database logs: Query performance data
    # - Error logs: 1,247 exceptions identified
    # 
    # 🚨 Key Findings:
    # - 67% increase in authentication timeouts starting 14:23 UTC
    # - Database connection pool exhaustion every ~30 minutes
    # - Memory leak pattern: heap usage +15MB every hour
    # - Specific user sessions causing 500ms+ response times
    # 
    # 🎯 Root Cause Analysis:
    # PRIMARY: New OAuth provider timeout (30s → 5s) causing cascading failures
    # SECONDARY: Connection pool size insufficient for traffic spike
    # CONTRIBUTING: Memory leak in session cleanup affecting performance
    # 
    # 📋 Recommendations:
    # 1. URGENT: Increase OAuth timeout configuration to 30s
    # 2. HIGH: Scale database connection pool from 20 → 50 connections  
    # 3. MEDIUM: Fix session cleanup memory leak in auth module
    # 4. LOW: Add monitoring for connection pool utilization
    ```

  </examples>
</instructions>