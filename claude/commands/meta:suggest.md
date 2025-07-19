# Suggest appropriate commands based on current context

<instructions>
  <context>
    Analyze current project context and $ARGUMENTS to suggest the most appropriate workflow commands for the situation.
  </context>

  <requirements>
    - Understanding of available command categories and their purposes
    - Ability to analyze project state and current needs
    - Knowledge of workflow patterns and best practices
  </requirements>

  <execution>
    1. **Context analysis**
       - Verify $ARGUMENTS is provided (current situation or goal description)
       - If no argument provided, show error: "Please describe your current situation or goal (e.g., 'starting new feature' or 'fixing production issue')"
       - Analyze current project state and git status
       - Identify ongoing work and pending tasks
       - Assess code quality and testing status
       - Review recent commits and development activity

    2. **Command recommendation logic**
       - Match situation to appropriate command categories
       - Consider workflow dependencies and prerequisites
       - Prioritize commands based on urgency and impact
       - Identify command sequences for complex workflows
       - Account for project-specific patterns and conventions
       - Consider team collaboration and review requirements

    3. **Suggestion presentation**
       - Present primary command recommendations with rationale
       - Suggest command sequences for multi-step workflows
       - Provide alternative approaches for different scenarios
       - Include brief descriptions of each suggested command
       - Explain workflow benefits and expected outcomes
       - Offer guidance on command parameters and usage
  </execution>

  <validation>
    - [ ] Current project context analyzed
    - [ ] Situation matched to appropriate command categories
    - [ ] Primary recommendations provided with rationale
    - [ ] Command sequences suggested for complex workflows
    - [ ] Alternative approaches presented
    - [ ] Usage guidance and expected outcomes included
  </validation>

  <workflow>
    **Meta-command workflow:**
    - `/meta:suggest` - Get command recommendations based on context (current)
    - Execute suggested commands in recommended sequence
    - `/meta:explain [command]` - Get detailed explanation of specific commands if needed

    **Prerequisites:** Clear description of current situation or goals
    **Next steps:** Execute recommended command sequence
    **Best used when:** Unsure which commands to use, planning complex workflows
  </workflow>

  <examples>
    ```bash
    # Get suggestions for starting new feature
    /meta:suggest "starting development of user dashboard feature"

    # Result: Suggests /research:codebase → /plan:requirements → /implement:feature → /validate:code
    ```

    ```bash
    # Get suggestions for production issue
    /meta:suggest "users reporting slow page load times"

    # Result: Suggests /debug:performance → /research:patterns → /implement:optimization → /validate:performance
    ```
  </examples>
</instructions>