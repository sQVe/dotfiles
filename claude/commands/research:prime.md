# Analyze project structure and provide codebase context

<instructions>
  <context>
    Analyze project structure, recent development history, and documentation to provide codebase context before starting work.
  </context>

  <requirements>
    - Git repository with commit history
    - Project documentation files (README, CLAUDE.md, etc.)
    - Access to file system for structure analysis
  </requirements>

  <execution>
    1. **Analyze project structure**
       - Generate directory tree overview showing key folders and files
       - Identify main entry points, configuration files, and architectural patterns
       - Understand technology stack and framework usage

    2. **Review development context**
       - Examine recent commit history for active development areas
       - Identify recent contributors and development patterns
       - Understand current branch state and any ongoing work

    3. **Study project documentation**
       - Read and summarize CLAUDE.md, README, and other key documentation
       - Extract project guidelines, conventions, and development practices
       - Identify important setup instructions or project-specific patterns
  </execution>

  <validation>
    - [ ] Project structure analyzed and key components identified
    - [ ] Recent development history reviewed
    - [ ] Project documentation read and summarized
    - [ ] Technology stack and architectural patterns identified
    - [ ] Current codebase state and context communicated
  </validation>

  <workflow>
    **Project onboarding workflow:**
    - `/research:prime` - Get comprehensive project overview (current)
    - `/research:codebase` - Deep dive into specific areas of interest
    - `/research:dependencies` - Understand dependency landscape
    - `/plan:requirements` - Begin feature or issue work

    **Prerequisites:** Access to project repository and documentation
    **Next steps:** Focused research on specific areas or begin planning
    **Best timing:** New project onboarding, returning to inactive project
  </workflow>

  <examples>
    ```bash
    # Standard project context gathering
    /prime

    # Process: analyze structure → review history → read docs
    # Result: Project overview with structure, recent changes, and guidelines
    ```

    ```bash
    # Context analysis includes:
    # - Directory structure and key files (src/, docs/, package.json)
    # - Recent commits and active development areas
    # - CLAUDE.md guidelines and project conventions
    # - Technology stack (React, TypeScript, etc.)
    # - Current branch state and any ongoing work
    ```

  </examples>
</instructions>
