# Validate manual style compliance against guidelines

<instructions>
  <context>
    Research style standards then validate $ARGUMENTS against project guidelines and conventions that automated tools cannot check.
  </context>

  <requirements>
    - Access to CLAUDE.md guidelines and project documentation
    - Target scope specification (files, "all", or "changes")
    - Ability to research style guides for programming languages
  </requirements>

  <execution>
    1. **Research standards and scope**
       - Research style guides for detected programming languages
       - Load CLAUDE.md guidelines: comment standards, naming patterns, code clarity
       - Reference project-specific style documents
       - Identify manual guidelines not covered by automated tools

    2. **Analyze compliance**
       - Check CLAUDE.md compliance: comment periods, redundant comments, clever code
       - Validate naming conventions and code organization principles
       - Assess code clarity and maintainability against standards
       - Review documentation patterns and comment quality

    3. **Report violations with citations**
       - Generate line-by-line feedback citing specific guidelines
       - Reference CLAUDE.md sections and style guide principles
       - Provide actionable fixes with examples
       - Categorize violations by source (CLAUDE.md, style guides, project-specific)
  </execution>

  <validation>
    - [ ] Style guides researched for programming languages
    - [ ] CLAUDE.md guidelines applied (comments, naming, clarity)
    - [ ] Project-specific conventions validated
    - [ ] Manual violations identified that tools cannot detect
    - [ ] Violations reported with citations and fixes
    - [ ] Multiple guideline sources referenced
    - [ ] Style compliance summary provided
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
