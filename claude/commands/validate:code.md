# Run automated code quality tools with linting and type checking

<instructions>
  <context>
    Execute automated code quality tools including linting, formatting, type checking, and static analysis on $ARGUMENTS with auto-fixing capabilities.
  </context>

  <requirements>
    - Project linting/formatting tools configured (biome, eslint, golangci-lint, etc.)
    - Type checking tools available (TypeScript, mypy, etc.)
    - Static analysis tools installed and configured
    - Target scope specification (specific files, "all", or "changes")
  </requirements>

  <execution>
    1. **Scope identification and automated formatting**
       - Run formatting tools (prettier, black, gofmt, etc.) with auto-fix enabled
       - Execute all configured linting tools with auto-fix capabilities enabled

    2. **Type safety and dependency verification**
       - Run type checking tools on the complete project (not scope-limited for consistency)
       - Verify import statements and dependency usage are correct
       - Check for any type-related warnings or inconsistencies

    3. **Static analysis and compilation checks**
       - Run static analysis tools to identify potential code issues
       - Check for syntax errors, compilation warnings, and structural problems
       - Validate that code builds/compiles successfully if applicable
  </execution>

  <validation>
    - [ ] Automated formatting applied successfully to specified scope
    - [ ] All linting tools executed with auto-fixes applied where possible
    - [ ] Type checking completes successfully with no type errors
    - [ ] Static analysis tools report no critical issues
    - [ ] Import statements and dependencies are valid
    - [ ] Code builds/compiles without errors if applicable
  </validation>

  <workflow>
    **Part of quality workflow:**
    1. `/validate:code` - Automated linting, formatting, type checking (current)
    2. `/validate:tests` - Test execution and coverage analysis
    3. `/validate:functionality` - Manual user workflow verification
    4. `/validate:style` - Manual guideline compliance check
    5. `/finalize:commit` - Create clean commits after validation

    **Prerequisites:** Run after making code changes but before committing
    **Next steps:** Continue with test validation or proceed to commit if all checks pass
  </workflow>

  <examples>
    ```bash
    # Run automated tools on specific directory
    /validate:code src/components/

    # Process: format with auto-fix → lint with auto-fix → typecheck → static analysis
    # Result: Automated quality validation with maximum auto-fixing applied
    ```

    ```bash
    # Validate all changed files with automated tools
    /validate:code changes

    # Process: identify modified files → auto-format → auto-lint → typecheck → static analysis
    # Result: Automated validation focused on recent changes with tool-based fixes
    ```

    ```bash
    # Example automated tool results
    # ✅ Prettier: 23 files formatted automatically
    # ✅ ESLint: 12 issues auto-fixed, 0 remaining (2,847 files checked)
    # ✅ TypeScript: Type checking passed (0 errors)
    # ✅ Build: Compilation successful
    # ⚠️  Static analysis: 2 potential issues detected (review recommended)
    ```

  </examples>
</instructions>
