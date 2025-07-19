# Reproduce and confirm reported issues systematically

<instructions>
  <context>
    Systematically reproduce reported issues for $ARGUMENTS to confirm their existence, understand scope, and gather detailed debugging information.
  </context>

  <requirements>
    - Issue description, ID, or reproduction steps to validate
    - Development environment that can match issue conditions
    - Access to relevant debugging tools and logs
    - Ability to document and update issue status
  </requirements>

  <execution>
    1. **Issue analysis and environment preparation**
       - Fetch issue details for $ARGUMENTS or analyze the described problem
       - Understand expected vs reported actual behavior
       - Prepare development environment to match issue conditions
       - Review any provided error messages, logs, or screenshots

    2. **Systematic reproduction and testing**
       - Follow reproduction steps exactly as provided or described
       - Document each step performed and its outcome systematically
       - Capture error messages, stack traces, and debugging information
       - Test variations and different environmental conditions if initial attempt fails
       - Verify issue occurs across different browsers, devices, or configurations as applicable

    3. **Documentation and issue update**
       - Record whether issue reproduces consistently, intermittently, or not at all
       - Document exact conditions under which issue occurs or fails to occur
       - Capture detailed logs and environmental factors for debugging
       - Update issue tracker with comprehensive reproduction results
       - Provide clear confirmation and suggest next steps for resolution
  </execution>

  <validation>
    - [ ] Issue details or description thoroughly analyzed and understood
    - [ ] Development environment prepared to match reported conditions
    - [ ] Reproduction steps followed systematically with documented outcomes
    - [ ] Environmental factors and variations tested appropriately
    - [ ] Clear determination made about reproducibility with supporting evidence
    - [ ] Detailed logs, error messages, and debugging information captured
    - [ ] Comprehensive results documented with actionable next steps
  </validation>

  <workflow>
    **Next steps after successful reproduction:**
    - `/debug:analyze` - Perform systematic root cause analysis
    - `/debug:performance` - If performance-related, analyze bottlenecks
    - `/implement:issue` - Implement solution for confirmed reproducible issues

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
