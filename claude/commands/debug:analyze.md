# Systematically analyze and debug complex technical problems

<instructions>
  <context>
    Systematically investigate and diagnose complex technical problems for $ARGUMENTS through methodical hypothesis testing and root cause analysis.
  </context>

  <requirements>
    - Problem description or symptoms to investigate
    - Access to logs, error traces, and diagnostic information
    - Development environment with debugging tools configured
    - Understanding of system architecture and component interactions
  </requirements>

  <execution>
    1. **Ultrathink: Strategic debugging analysis**
       - Use sequential thinking to analyze $ARGUMENTS scope, potential root causes, and debugging approaches
       - Break down the problem systematically: symptoms → possible causes → investigation strategies
       - Consider multiple debugging angles: code analysis, environment factors, timing patterns, recent changes
       - Plan the most effective debugging sequence based on available information and likelihood of causes

    2. **Problem analysis and information gathering**
       - Verify $ARGUMENTS is provided (problem description required)
       - If no argument provided, show error: "Please specify what to debug (e.g., 'database timeout errors', 'intermittent login failures')"
       - Collect all available error messages, stack traces, and log entries for $ARGUMENTS
       - Gather reproduction steps and environmental conditions
       - Review recent changes, deployments, or configuration modifications
       - Document symptoms, impact scope, and timing patterns

    3. **Systematic hypothesis formation and testing**
       - Identify affected components, services, or code paths
       - Generate multiple potential root cause hypotheses based on evidence
       - Prioritize hypotheses by likelihood and available diagnostic information
       - Design specific tests to validate or refute each hypothesis systematically
       - Use debugging tools, breakpoints, and logging to trace execution paths

    4. **Root cause identification and solution development**
       - Identify the underlying cause through evidence-based investigation
       - Verify the root cause by reproducing the issue and confirming the fix
       - Design and implement a targeted solution that addresses the root cause
       - Test the solution thoroughly to ensure it resolves the problem
       - Document the debugging process, findings, and resolution steps
  </execution>

  <validation>
    - [ ] Problem description analyzed and symptoms documented
    - [ ] All available diagnostic information collected and reviewed
    - [ ] Multiple hypotheses generated and systematically tested
    - [ ] Root cause identified and verified through evidence
    - [ ] Solution addresses the underlying cause, not just symptoms
    - [ ] Fix tested thoroughly and confirmed to resolve the issue
    - [ ] Debugging process and findings comprehensively documented
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
