# Analyze project context and suggest appropriate next commands

<instructions>
  <context>
    Analyze current project context and suggest appropriate next commands for $ARGUMENTS development phase with clear rationale and workflow guidance.
  </context>

  <requirements>
    - Git repository access for status and branch analysis
    - Understanding of available command categories and their purposes
    - Ability to detect development phase and project state
    - Knowledge of common development workflow patterns
  </requirements>

  <execution>
    1. **Context analysis and phase detection**
       - Check $ARGUMENTS for specific workflow context ("feature", "bugfix", "review", or auto-detect)
       - Analyze git status: uncommitted changes, current branch, recent commits
       - Examine recent file modifications and project activity patterns
       - Identify current development phase: starting, coding, testing, reviewing, finishing

    2. **Workflow pattern recognition**
       - Match detected context to common development scenarios
       - Consider project state: new repo, active development, code review, production issues
       - Identify logical next steps based on established workflow patterns
       - Reference available commands that fit the current situation

    3. **Command recommendation and guidance**
       - Suggest 1-3 most appropriate next commands with clear rationale
       - Provide workflow sequence examples for the detected scenario
       - Include brief explanations of why each command fits the current context
       - Show common command combinations and their typical flow patterns

  </execution>

  <validation>
    - [ ] Current development phase accurately detected from project context
    - [ ] Workflow pattern correctly matched to available commands
    - [ ] 1-3 specific command recommendations provided with clear rationale
    - [ ] Each suggestion includes explanation of why it fits current context
    - [ ] Common workflow sequences shown for detected scenario
    - [ ] Guidance helps user understand logical next steps without overwhelming choice
    - [ ] Recommendations follow established development workflow best practices
  </validation>

  <examples>
    ```bash
    # Auto-detect current workflow context
    /plan:workflow

    # Process: analyze git status → detect phase → match patterns → suggest commands
    # Result: Contextual command suggestions based on current project state
    ```

    ```bash
    # Specify workflow context for targeted guidance
    /plan:workflow feature

    # Process: feature development context → identify appropriate commands → provide sequence
    # Result: Feature development workflow with logical command progression
    ```

    ```bash
    # Example output for active development
    # Current context: Feature branch with uncommitted changes
    # Suggested workflow:
    # 1. /validate:code changes - Verify code quality before commit
    # 2. /validate:tests changes - Ensure tests pass for modifications
    # 3. /finalize:commit - Create atomic commits with clear messages
    # Next: /finalize:pr when feature complete
    ```

  </examples>
</instructions>
