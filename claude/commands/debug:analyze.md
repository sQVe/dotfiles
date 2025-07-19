# Debug complex problems with systematic analysis

<instructions>
  <context>
    Debug complex technical problems for $ARGUMENTS through methodical hypothesis testing and root cause analysis.
  </context>

  <requirements>
    - Problem description with symptoms to investigate
    - Access to logs, debugging tools, and system architecture knowledge
  </requirements>

  <execution>
    1. **Ultrathink: Strategic debugging analysis**
       - Use sequential thinking to analyze $ARGUMENTS scope, potential root causes, and debugging approaches
       - Break down the problem: symptoms → possible causes → investigation strategies
       - Consider debugging angles: code analysis, environment factors, timing patterns, recent changes
       - Plan effective debugging sequence based on available information and likelihood

    2. **Gather diagnostic information**
       - Collect error messages, stack traces, and log entries
       - Document reproduction steps and environmental conditions
       - Review recent changes, deployments, or configuration modifications
       - Map symptoms, impact scope, and timing patterns

    3. **Form and test hypotheses**
       - Identify affected components and code paths
       - Generate and prioritize hypotheses based on evidence
       - Design specific tests to validate or refute each hypothesis
       - Use debugging tools, breakpoints, and logging to trace execution

    4. **Identify root cause and implement solution**
       - Verify the underlying cause through evidence-based investigation
       - Design and implement targeted solution addressing the root cause
       - Test solution thoroughly to ensure it resolves the problem
       - Document debugging process, findings, and resolution steps
  </execution>

  <validation>
    - [ ] Problem and symptoms documented
    - [ ] Diagnostic information collected
    - [ ] Hypotheses tested systematically
    - [ ] Root cause identified and verified
    - [ ] Solution implemented and tested
  </validation>

  <workflow>
    **Debugging workflow:**
    - `/debug:reproduce` - Confirm issue reproduction (recommended first)
    - `/debug:analyze` - Systematic root cause analysis (current)
    - `/research:codebase` - Understand related code patterns if needed
    - `/implement:resolve` - Implement targeted solution based on analysis
    - `/validate:tests` - Ensure fix works and prevent regression

    **Prerequisites:** Reproducible issue or clear symptoms
    **Next steps:** Implementation of solution based on analysis findings
    **Complements:** `/debug:performance` for performance issues, `/debug:production` for production-specific problems
  </workflow>

  <examples>
    ```bash
    # Debug specific technical problem
    /debug:analyze "database connection timeouts in production"

    # Process: analyze symptoms → gather diagnostics → test hypotheses → identify root cause → implement solution
    # Result: Systematic debugging with documented solution and prevention measures
    ```

    ```bash
    # Debug complex intermittent issue
    /debug:analyze "users randomly logged out during active sessions"

    # Process includes:
    # - Pattern analysis across user reports and session logs
    # - Hypothesis testing: token expiration, race conditions, memory issues
    # - Root cause identification through systematic elimination
    # - Solution implementation with monitoring to prevent recurrence
    ```

  </examples>
</instructions>
