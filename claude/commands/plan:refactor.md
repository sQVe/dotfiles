# Plan comprehensive refactoring strategy

<instructions>
  <context>
    Plan comprehensive refactoring strategy for $ARGUMENTS through analysis of current state, refactoring needs, and implementation approach.
  </context>

  <requirements>
    - Understanding of code architecture and refactoring principles
    - Access to codebase and existing documentation
    - Knowledge of testing strategies and risk assessment
    - Ability to break down complex refactoring into manageable steps
  </requirements>

  <execution>
    1. **Quick analysis: Refactoring scope and comprehensive strategy**
       - Analyze $ARGUMENTS current state and identify complete refactoring requirements
       - Plan refactoring approach: architecture changes, code improvements, risk mitigation
       - Determine optimal refactoring sequence and dependency management

    2. **Current state analysis**
       - Assess existing code structure, patterns, and technical debt
       - Identify pain points, bottlenecks, and maintainability issues
       - Map dependencies, integrations, and impact areas
       - Document current behavior and business logic

    3. **Refactoring strategy design**
       - Define target architecture and improvement goals
       - Plan incremental refactoring steps with clear milestones
       - Identify testing requirements and validation checkpoints
       - Assess risks and plan mitigation strategies
       - Design backwards compatibility and rollback approaches

    4. **Implementation planning**
       - Break down refactoring into manageable, testable chunks
       - Create timeline with dependencies and resource requirements
       - Plan testing strategy for each refactoring phase
       - Document decision rationale and alternative approaches
       - Prepare communication plan for stakeholders
  </execution>

  <validation>
    - [ ] Current state thoroughly analyzed and documented
    - [ ] Refactoring goals and success criteria defined
    - [ ] Implementation broken into manageable incremental steps
    - [ ] Dependencies and impact areas identified
    - [ ] Testing strategy planned for each refactoring phase
    - [ ] Risk assessment completed with mitigation plans
    - [ ] Timeline and resource requirements documented
    - [ ] Backwards compatibility and rollback strategies planned
  </validation>

  <workflow>
    **Part of refactoring workflow:**
    1. `/plan:refactor` - Plan comprehensive refactoring strategy (current)
    2. `/implement:tests` - Ensure comprehensive test coverage before refactoring
    3. `/implement:refactor` - Execute planned refactoring in incremental steps
    4. `/validate:review` - Review each refactoring increment
    5. `/validate:functionality` - Verify behavior preservation
    6. `/finalize:commit` - Commit incremental refactoring changes

    **Prerequisites:** Code analysis complete, refactoring needs identified
    **Next steps:** Implement comprehensive test coverage, begin incremental refactoring
    **Best practices:** Plan small, testable increments with validation checkpoints
  </workflow>

  <examples>
    ```bash
    # Plan refactoring for legacy authentication system
    /plan:refactor "authentication and session management system"

    # Process: analyze current state → design target architecture → plan incremental steps → risk assessment
    # Result: Comprehensive refactoring plan with timeline and risk mitigation
    ```

    ```bash
    # Plan database schema refactoring
    /plan:refactor "user and permissions database schema"

    # Process includes:
    # - Current state: analyze existing schema, relationships, performance issues
    # - Target design: normalize schema, improve performance, add flexibility
    # - Migration strategy: data migration, schema versioning, backwards compatibility
    # - Risk assessment: downtime requirements, rollback procedures
    # - Testing plan: data integrity, performance validation, application compatibility
    # - Timeline: phased migration with validation checkpoints
    ```

    ```bash
    # Example refactoring plan results
    # 🔍 Current State Analysis:
    # - Legacy authentication: 3,200 lines across 8 files
    # - Tight coupling between auth, session, and user management
    # - Technical debt: hardcoded configs, no proper error handling
    # - Performance issues: N+1 queries, synchronous operations
    # - Test coverage: 23% (target: 90%+)
    # 
    # 🎯 Refactoring Goals:
    # - Separate concerns: auth, session, user management modules
    # - Improve performance: async operations, query optimization
    # - Enhance security: proper token handling, input validation
    # - Increase testability: dependency injection, mocking support
    # 
    # 📋 Implementation Plan (6 phases):
    # Phase 1 (Week 1): Add comprehensive test coverage
    #   - Write unit tests for existing functionality
    #   - Add integration tests for auth flows
    #   - Establish baseline performance benchmarks
    # 
    # Phase 2 (Week 2): Extract session management
    #   - Create SessionManager class with clear interface
    #   - Migrate session logic incrementally
    #   - Validate session functionality preservation
    # 
    # Phase 3-6: Continue with auth service, user management, performance optimization...
    # 
    # ⚠️  Risk Assessment:
    # - HIGH: Session invalidation during migration (mitigation: graceful fallback)
    # - MEDIUM: Performance regression (mitigation: benchmarking at each phase)
    # - LOW: API breaking changes (mitigation: backwards compatibility layer)
    ```

  </examples>
</instructions>