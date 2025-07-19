# Validate code changes through comprehensive review

<instructions>
  <context>
    Perform comprehensive code review for $ARGUMENTS through analysis of code quality, architecture, performance, and improvement opportunities.
  </context>

  <requirements>
    - Access to git changes and codebase context
    - Understanding of code quality principles and best practices
    - Knowledge of language idioms and framework conventions
    - Ability to identify refactoring and optimization opportunities
  </requirements>

  <execution>
    1. **Quick analysis: Review scope and comprehensive strategy**
       - Analyze $ARGUMENTS changes scope and identify thorough review strategy
       - Plan review areas: code quality, architecture, performance, bug prevention, best practices
       - Determine optimal review sequence for comprehensive assessment

    2. **Deep code analysis**
       - Analyze code quality: maintainability, readability, complexity
       - Review architecture: design patterns, structure, coupling, cohesion
       - Assess performance implications and optimization opportunities
       - Identify potential bugs: edge cases, error handling, logic issues
       - Check language idioms and framework convention adherence

    3. **Improvement identification**
       - Identify refactoring opportunities for simplification
       - Suggest architectural improvements and pattern applications
       - Recommend performance optimizations where beneficial
       - Propose bug prevention and robustness improvements
       - Document best practice violations and corrections

    4. **Final recommendations**
       - Prioritize improvements by impact and effort
       - Provide actionable recommendations with rationale
       - Suggest commit readiness or required changes
       - Document key insights for future development
  </execution>

  <validation>
    - [ ] Git changes analyzed comprehensively
    - [ ] Code quality issues identified and documented
    - [ ] Architecture improvements suggested with rationale
    - [ ] Performance implications reviewed and optimized
    - [ ] Bug prevention opportunities identified
    - [ ] Best practice violations documented with fixes
    - [ ] Refactoring opportunities assessed and prioritized
    - [ ] Actionable improvement recommendations provided
  </validation>

  <workflow>
    **Part of validation workflow:**
    1. `/validate:code` - Automated linting, formatting, type checking
    2. `/validate:tests` - Test execution and coverage analysis
    3. `/validate:review` - Comprehensive code review and improvements (current)
    4. `/validate:style` - Manual guideline compliance check
    5. `/finalize:commit` - Create clean commits after validation

    **Prerequisites:** Code changes made, basic automated validation completed
    **Next steps:** Address review findings, continue validation workflow
    **Best timing:** Before final commit, after initial implementation
  </workflow>

  <examples>
    ```bash
    # Review all modified files comprehensively
    /validate:review "changes"

    # Process: analyze scope → deep code analysis → identify improvements → prioritized recommendations
    # Result: Comprehensive review with actionable improvement suggestions
    ```

    ```bash
    # Review specific component implementation
    /validate:review "UserAuthentication component"

    # Process includes:
    # - Code quality: readability, maintainability, complexity analysis
    # - Architecture: design patterns, separation of concerns, coupling
    # - Performance: optimization opportunities, bottleneck identification
    # - Bug prevention: edge cases, error handling, input validation
    # - Best practices: language idioms, framework conventions
    # - Refactoring: simplification and improvement opportunities
    ```

    ```bash
    # Example comprehensive review findings
    # 🔍 Code Quality:
    # ✅ Clean, readable function names and structure
    # ⚠️  High cyclomatic complexity in validateUser() - consider splitting
    # 
    # 🏗️ Architecture:
    # ✅ Good separation of concerns between auth and data layers
    # 💡 Consider implementing Strategy pattern for multiple auth providers
    # 
    # ⚡ Performance:
    # ⚠️  N+1 query pattern in getUserPermissions() - use batch loading
    # 💡 Add caching layer for frequently accessed user data
    # 
    # 🐛 Bug Prevention:
    # ❌ Missing input validation on email parameter
    # ❌ Race condition possible in concurrent login attempts
    # 
    # 📋 Recommendations (prioritized):
    # 1. HIGH: Add input validation to prevent security issues
    # 2. MEDIUM: Refactor validateUser() to reduce complexity
    # 3. LOW: Consider caching optimization for better performance
    ```

  </examples>
</instructions>