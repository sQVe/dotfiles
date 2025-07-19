# Proofread and validate documentation for grammar, style, and consistency

<instructions>
  <context>
    Research documentation standards then validate $ARGUMENTS for grammar, style consistency, clarity, and adherence to documentation best practices.
  </context>

  <requirements>
    - Target documentation files or scope specification (specific files, "all", or "changes")
    - Access to project documentation guidelines and style guides
    - Understanding of current documentation standards and best practices
  </requirements>

  <execution>
    1. **Research standards and identify scope**
       - Research current documentation best practices and style guides for project type
       - Load project-specific documentation guidelines from CLAUDE.md and style guides
       - Identify documentation standards: markdown conventions, tone, structure patterns

    2. **Validate grammar and style**
       - Check spelling, grammar, and punctuation across all specified documents
       - Validate markdown syntax and formatting consistency
       - Ensure consistent tone, voice, and writing style throughout documents
       - Verify proper heading hierarchy and structural organization
       - Check for consistent terminology usage and technical accuracy

    3. **Analyze content structure and accessibility**
       - Validate document structure follows logical information hierarchy
       - Check for clear section organization with appropriate headings
       - Ensure proper use of lists, code blocks, and formatting elements
       - Verify links are functional and point to correct destinations
       - Assess readability and accessibility for different audience levels
       - Check for consistent formatting of code examples and technical terms
  </execution>

  <validation>
    - [ ] Documentation standards researched for project context
    - [ ] Scope identified and appropriate files analyzed
    - [ ] Grammar, spelling, and punctuation validated
    - [ ] Markdown syntax and formatting consistency verified
    - [ ] Writing style and tone consistency maintained
    - [ ] Document structure and heading hierarchy organized
    - [ ] Technical terminology used consistently
    - [ ] Links validated and functional
    - [ ] Code examples properly formatted
    - [ ] Readability assessed for target audience
    - [ ] Project-specific documentation guidelines applied
  </validation>

  <workflow>
    **Part of quality workflow:**
    1. `/validate:code` - Automated linting, formatting, type checking
    2. `/validate:tests` - Test execution and coverage analysis
    3. `/validate:docs` - Documentation proofreading and style validation (current)
    4. `/validate:style` - Manual code guideline compliance check
    5. `/finalize:commit` - Create clean commits after validation

    **Prerequisites:** Run after documentation changes but before committing
    **Next steps:** Continue with style validation or proceed to commit if all checks pass

  </workflow>

  <examples>
    ```bash
    # Validate specific documentation file
    /validate:docs README.md

    # Process: research standards → check grammar/style → validate structure → verify links
    # Result: Comprehensive documentation validation with grammar and consistency checks
    ```

    ```bash
    # Validate all documentation changes
    /validate:docs changes

    # Process: identify modified docs → apply standards → grammar check → style validation
    # Result: Focused validation on recently changed documentation files
    ```

    ```bash
    # Example documentation issues detected
    # README.md:15
    # ❌ Grammar: "it's capabilities" should be "its capabilities"
    # 📖 Violates: Standard grammar rules - possessive pronouns
    # ✅ Fix: Remove apostrophe for possessive "its"
    #
    # docs/api.md:42
    # ❌ Inconsistent terminology: Mix of "login" and "log in" usage
    # 📖 Violates: @guidelines/documentation.md - "Use consistent terminology"
    # ✅ Fix: Choose one form and use consistently (recommend "log in" as verb, "login" as noun)
    #
    # CONTRIBUTING.md:23
    # ❌ Broken link: [Style Guide](./docs/style.md) returns 404
    # 📖 Violates: Documentation accessibility standards
    # ✅ Fix: Update link to correct path or create missing file
    #
    # docs/setup.md:8
    # ❌ Code block missing language specification
    # 📖 Violates: Markdown best practices - syntax highlighting
    # ✅ Fix: Add language identifier: ```bash instead of ```
    ```

  </examples>
</instructions>
