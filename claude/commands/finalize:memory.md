# Create structured memory documentation of current work session

<instructions>
  <context>
    Generate structured documentation of current project state, decisions, and context for $ARGUMENTS scope to maintain continuity.
  </context>

  <requirements>
    - Access to recent project activity, commits, and changes
    - Understanding of current project context and goals
    - Ability to analyze recent decisions and implementation patterns
    - Knowledge of project architecture and technical choices
  </requirements>

  <execution>
    1. **Scope identification and context gathering**
       - Verify $ARGUMENTS is provided (scope required: "session", "project", or specific feature)
       - If no scope provided, show error: "Please specify what to document (e.g., 'session', 'project', 'feature authentication')"
       - Gather recent activity, commits, decisions, and changes for specified scope
       - Analyze current project state and implementation context

    2. **Structured analysis and documentation**
       - Document key decisions made and their rationale
       - Capture implementation patterns, conventions, and lessons learned
       - Analyze current architecture choices and technical decisions
       - Identify blockers, challenges faced, and solutions implemented

    3. **Memory formatting and file creation**
       - Append structured entry to MEMORY.md in project root with timestamp header
       - Use standard format: ## [Scope] - [Date] [Time], followed by structured sections
       - Include sections: Context, Key Decisions, Implementation Patterns, Lessons Learned, Next Steps
       - Format for searchability with clear headings and consistent structure
  </execution>

  <validation>
    - [ ] Entry appended to MEMORY.md with proper timestamp header format
    - [ ] All required sections included: Context, Key Decisions, Implementation Patterns, Lessons Learned, Next Steps
    - [ ] Key decisions captured with rationale and implementation context
    - [ ] Implementation patterns, conventions, and lessons learned recorded
    - [ ] Current project state and architecture accurately reflected
    - [ ] Challenges, blockers, and solutions documented for future reference
    - [ ] Next steps formatted as actionable items for continuing work
  </validation>

  <workflow>
    **Memory documentation workflow:**
    - Complete work session or reach natural stopping point
    - `/finalize:memory` - Document session context and decisions (current)
    - Use memory documentation to resume work efficiently
    - Reference MEMORY.md when returning to project after time away

    **Prerequisites:** Completed work session with decisions and implementations
    **Next steps:** Resume work using documented context
    **Best timing:** End of work sessions, major implementation milestones, before switching projects
  </workflow>

  <examples>
    ```bash
    # Document current work session state and decisions
    /finalize:memory session

    # Process: gather session context → analyze decisions → document patterns → format summary
    # Result: Structured session summary with decisions, lessons learned, and next steps
    ```

    ```bash
    # Create comprehensive project memory documentation
    /finalize:memory project

    # Process: analyze project state → document architecture → capture lessons → provide roadmap
    # Result: Complete project context documentation for future development continuity
    ```

    ```bash
    # Document specific feature implementation memory
    /finalize:memory feature authentication

    # Process: analyze feature work → document patterns → capture decisions → next steps
    # Result: Feature-specific memory with implementation details and future considerations
    ```

    ```markdown
    # Example MEMORY.md output structure:
    ## Session - 2024-07-18 14:30

    ### Context
    Command refactoring session focusing on validation command consistency and new memory command creation.

    ### Key Decisions
    - Standardized $ARGUMENTS verification across all validate commands
    - Added finalize:memory command for structured documentation
    - Chose single MEMORY.md file with timestamps over separate files

    ### Implementation Patterns
    - Consistent error message format: "Please specify [what] (e.g., '[example]')"
    - Standard validation command structure with 3 execution steps
    - Memory documentation uses Context → Decisions → Patterns → Lessons → Next Steps

    ### Lessons Learned
    - Command consistency requires explicit auditing and standardization
    - Memory capture prevents loss of context between sessions
    - Structured templates improve command quality and usability

    ### Next Steps
    - [ ] Complete plan:improvements.md command
    - [ ] Standardize legacy commands to 3-step structure
    - [ ] Update REFACTOR_IMPLEMENTATION.md with memory command details
    ```

  </examples>
</instructions>
