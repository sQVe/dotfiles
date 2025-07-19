# Reproduce and confirm reported issues

<instructions>
  <context>
    Reproduce reported issues for $ARGUMENTS to confirm their existence, understand scope, and gather debugging information.
  </context>

  <requirements>
    - Issue description, ID, or reproduction steps to validate
    - Development environment that can match issue conditions
    - Access to relevant debugging tools and logs
  </requirements>

  <execution>
    1. **Analyze issue and prepare environment**
       - Fetch issue details for $ARGUMENTS or analyze the described problem
       - Understand expected vs reported actual behavior
       - Prepare development environment to match issue conditions
       - Review provided error messages, logs, or screenshots

    2. **Reproduce and test systematically**
       - Follow reproduction steps exactly as provided
       - Document each step performed and its outcome
       - Capture error messages, stack traces, and debugging information
       - Test variations and different environmental conditions if needed
       - Verify issue occurs across different browsers, devices, or configurations

    3. **Document results and update issue**
       - Record whether issue reproduces consistently, intermittently, or not at all
       - Document exact conditions under which issue occurs
       - Capture detailed logs and environmental factors for debugging
       - Update issue tracker with reproduction results
       - Provide clear confirmation and suggest next steps
  </execution>

  <validation>
    - [ ] Issue details analyzed and understood
    - [ ] Development environment prepared to match conditions
    - [ ] Reproduction steps followed with documented outcomes
    - [ ] Environmental factors and variations tested
    - [ ] Clear determination made about reproducibility
    - [ ] Logs, error messages, and debugging information captured
    - [ ] Results documented with actionable next steps
  </validation>

  <workflow>
    **Next steps after successful reproduction:**
    - `/debug:analyze` - Perform root cause analysis
    - `/debug:performance` - If performance-related, analyze bottlenecks
    - `/implement:resolve` - Implement solution for confirmed reproducible issues

    **If reproduction fails:**
    - `/research:codebase` - Analyze existing patterns to understand expected behavior
    - `/research:external` - Research documentation for proper usage patterns
  </workflow>

  <examples>
    ```bash
    # Reproduce specific GitHub issue
    /debug:reproduce "#789"

    # Process: fetch issue details → prepare environment → follow reproduction steps → document results
    # Result: Confirmed issue reproduction with detailed debugging information and next steps
    ```

    ```bash
    # Reproduce described problem
    /debug:reproduce "users can't upload files larger than 5MB"

    # Process includes:
    # - Test file uploads with various sizes and types
    # - Check network logs for failed upload attempts
    # - Verify server logs for processing errors
    # - Document exact thresholds and error conditions
    # - Provide detailed reproduction report with debugging insights
    ```

  </examples>
</instructions>
