# Create structured memory documentation

<instructions>
  <context>
    Generate structured documentation of current project state, decisions, and context for $ARGUMENTS scope to maintain continuity.
  </context>

  <requirements>
    - Access to recent project activity, commits, and changes
    - Understanding of current project context and goals
    - Knowledge of project architecture and technical choices
  </requirements>

  <execution>
    1. **Gather scope and context**
       - Gather recent activity, commits, decisions, and changes for specified scope
       - Analyze current project state and implementation context

    2. **Analyze and document**
       - Document key decisions made and their rationale
       - Capture implementation patterns, conventions, and lessons learned
       - Identify blockers, challenges faced, and solutions implemented

    3. **Format and create memory entry**
       - Append structured entry to MEMORY.md in project root with timestamp
       - Use format: ## [Scope] - [Date] [Time], followed by structured sections
       - Include sections: Context, Key Decisions, Implementation Patterns, Lessons Learned, Next Steps
  </execution>

  <validation>
    - [ ] Entry appended to MEMORY.md with proper timestamp header
    - [ ] All required sections included with structured content
    - [ ] Key decisions captured with rationale
    - [ ] Implementation patterns and lessons learned recorded
    - [ ] Current project state accurately reflected
    - [ ] Challenges and solutions documented
    - [ ] Next steps formatted as actionable items
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
