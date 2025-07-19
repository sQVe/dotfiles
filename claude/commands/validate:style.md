# Validate manual style compliance against project guidelines

<instructions>
  <context>
    Research current style standards then manually validate $ARGUMENTS against project-specific guidelines and coding conventions that automated tools cannot check.
  </context>

  <requirements>
    - Access to CLAUDE.md guidelines and project documentation (CONTRIBUTING.md, README.md)
    - Target code files or scope specification (specific files, "all", or "changes")
    - Ability to research current style guides for detected programming languages
    - Git access for "changes" scope to analyze modified files
  </requirements>

  <execution>
    1. **Standards research and scope identification**
       - Verify $ARGUMENTS is provided (scope required: files, "all", or "changes")
       - If no scope provided, show error: "Please specify what to validate (e.g., 'Button.tsx', 'all', 'changes')"
       - Research current style guides and manual conventions for detected programming languages
       - Load CLAUDE.md guidelines: comment standards, naming patterns, code clarity principles
       - Reference project-specific style documents (CONTRIBUTING.md, style guides)
       - Identify manual guideline categories not covered by automated tools

    2. **Manual guideline compliance analysis**
       - Check CLAUDE.md compliance: comment periods, redundant comment detection, clever code patterns
       - Validate naming conventions and code organization principles from guidelines
       - Assess code clarity and maintainability against readability standards
       - Review documentation patterns and inline comment quality
       - Analyze adherence to project-specific manual conventions

    3. **Detailed violation reporting with guideline citations**
       - Generate line-by-line feedback citing specific manual guidelines and standards
       - Reference CLAUDE.md sections and researched style guide principles
       - Provide actionable fix suggestions with examples from style guides
       - Categorize violations by guideline source (CLAUDE.md, language style guides, project-specific)
  </execution>

  <validation>
    - [ ] Current style guides researched for detected programming languages
    - [ ] Scope correctly identified and appropriate files analyzed
    - [ ] CLAUDE.md manual guidelines applied (comment standards, naming, code clarity)
    - [ ] Project-specific manual conventions validated against documentation
    - [ ] Manual style violations identified that automated tools cannot detect
    - [ ] Violations reported with line numbers, guideline citations, and actionable fixes
    - [ ] Multiple guideline sources clearly cited (CLAUDE.md, style guides, project docs)
    - [ ] Manual style compliance summary provided with specific guideline references
  </validation>

  <workflow>
    **Part of validation workflow:**
    1. `/validate:code` - Automated linting, formatting, type checking
    2. `/validate:tests` - Test execution and coverage analysis
    3. `/validate:functionality` - Manual user workflow verification
    4. `/validate:style` - Manual guideline compliance check (current)
    5. `/finalize:commit` - Create clean commits after validation

    **Prerequisites:** Code changes made, automated validation completed
    **Next steps:** Address style violations, proceed to commit
    **Complements:** `/validate:code` for automated style checks that tools can catch
  </workflow>

  <examples>
    ```bash
    # Validate manual style guidelines for specific component
    /validate:style Button.tsx

    # Process: research style guides → load CLAUDE.md rules → analyze manual compliance → report violations
    # Result: Manual guideline violations that automated tools cannot detect
    ```

    ```bash
    # Validate all modified files for manual style compliance
    /validate:style changes

    # Process: research standards → identify changed files → apply manual guidelines → generate compliance report
    # Result: Manual style validation focused on guidelines not covered by automated tools
    ```

    ```bash
    # Example manual style violations detected
    # src/components/Button.tsx:23
    # ❌ Redundant comment: `i++; // increment i`
    # 📖 Violates: @guidelines/code-quality.md - "Avoid redundant comments"
    # ✅ Fix: Remove comment or make code self-explanatory
    #
    # src/utils/auth.js:45
    # ❌ Comment missing period: `// Check if user is authenticated`
    # 📖 Violates: @guidelines/documentation-workflow.md - "End code comments with a period"
    # ✅ Fix: `// Check if user is authenticated.`
    #
    # src/helpers/data.py:12
    # ❌ Clever code pattern: Complex one-liner that obscures intent
    # 📖 Violates: @guidelines/code-quality.md - "No clever tricks, clear obvious code only"
    # ✅ Fix: Break into multiple clear steps with descriptive variable names
    ```

  </examples>
</instructions>
