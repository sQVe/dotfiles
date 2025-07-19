# Implement new feature with structured development workflow

<instructions>
  <context>
    Implement a new feature for $ARGUMENTS following established patterns, best practices, and comprehensive testing to ensure quality and maintainability.
  </context>

  <requirements>
    - Clear feature requirements and specifications
    - Understanding of existing codebase patterns and architecture
    - Access to testing frameworks and development tools
  </requirements>

  <execution>
    1. **Quick analysis: Feature implementation scope and approach**
       - Analyze $ARGUMENTS feature requirements and identify efficient implementation strategy
       - Plan implementation areas: architecture design, development patterns, testing approach
       - Determine optimal implementation sequence for reliable feature delivery

    2. **Feature planning and design**
       - Analyze feature requirements and acceptance criteria
       - Design feature architecture and component structure
       - Plan API endpoints, data models, and user interface changes
       - Identify integration points and potential conflicts

    3. **Implementation with established patterns**
       - Create feature branch following project conventions
       - Implement backend components (models, controllers, services)
       - Develop frontend components following design system
       - Add proper error handling and validation
       - Implement security measures and access controls
       - Follow established coding patterns and conventions

    4. **Testing and validation**
       - Write unit tests for all new components and functions
       - Create integration tests for API endpoints and workflows
       - Add end-to-end tests for complete user journeys
       - Test edge cases and error scenarios
       - Validate accessibility and performance requirements
       - Ensure feature works across different environments
  </execution>

  <validation>
    - [ ] Feature requirements analyzed and design completed
    - [ ] Backend components implemented with proper patterns
    - [ ] Frontend components follow design system and conventions
    - [ ] Error handling and validation properly implemented
    - [ ] Security measures and access controls added
    - [ ] Comprehensive test suite covering all scenarios
    - [ ] Feature tested in different environments
  </validation>

  <workflow>
    **Feature development workflow:**
    - `/plan:requirements` - Define feature requirements and acceptance criteria
    - `/research:codebase` - Understand existing patterns and architecture
    - `/plan:synthesis` - Create implementation plan and technical decisions
    - `/implement:feature` - Execute feature development (current)
    - `/validate:code` - Automated quality checks and linting
    - `/validate:tests` - Comprehensive testing and coverage
    - `/validate:functionality` - Manual feature validation and UX testing
    - `/validate:security` - Security validation for new feature
    - `/finalize:commit` - Create focused commits with clear messages

    **Prerequisites:** Clear requirements and implementation plan
    **Next steps:** Complete validation workflow before deployment
  </workflow>

  <examples>
    ```bash
    # Implement user profile feature
    /implement:feature "user profile management with avatar upload"

    # Process: design → implement backend → frontend → testing → validation
    # Result: Complete feature implementation with tests and documentation
    ```

    ```bash
    # Implement complex feature with integrations
    /implement:feature "payment processing with Stripe integration"

    # Process includes:
    # - Design payment flow and error handling
    # - Implement secure payment endpoints with validation
    # - Create payment UI components with loading states
    # - Add webhook handling for payment status updates
    # - Test payment flows including failure scenarios
    # - Validate PCI compliance and security measures
    ```
  </examples>
</instructions>