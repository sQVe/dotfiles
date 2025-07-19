# Initialize new work with proper setup and context gathering

<instructions>
  <context>
    Initialize and set up new work scenarios for $ARGUMENTS including contributor onboarding, project creation, and feature preparation with comprehensive context gathering.
  </context>

  <requirements>
    - Clear initialization goal or scenario to set up
    - Access to project documentation and development environment
    - Understanding of team workflows and development practices
    - Ability to create project structure and documentation
  </requirements>

  <execution>
    1. **Initialization scope analysis and preparation**
       - Analyze the initialization requirements for $ARGUMENTS
       - Identify necessary tools, dependencies, and environment setup needs
       - Gather relevant documentation, guidelines, and project context
       - Assess existing project structure and development workflow patterns

    2. **Setup planning and environment configuration**
       - Create comprehensive setup checklist for the specified initialization type
       - Plan development environment configuration and tool installation
       - Identify required access, permissions, and account setup needs
       - Design onboarding documentation and context-sharing strategy
       - Plan integration with existing team workflows and communication channels

    3. **Implementation guidance and workflow establishment**
       - Provide step-by-step initialization instructions with clear milestones
       - Create initial project structure or workspace organization
       - Establish development workflow and next-step recommendations
       - Document setup decisions and provide troubleshooting guidance
       - Connect initialization to appropriate follow-up commands for continued work
  </execution>

  <validation>
    - [ ] Initialization scope clearly defined and requirements analyzed
    - [ ] Comprehensive setup checklist created for specified scenario
    - [ ] Development environment configuration planned and documented
    - [ ] Required access, tools, and dependencies identified
    - [ ] Step-by-step initialization instructions provided with clear milestones
    - [ ] Integration with existing workflows and team practices established
    - [ ] Follow-up workflow recommendations provided for continued development
  </validation>

  <workflow>
    **Initialization workflow:**
    - `/plan:init` - Set up new work scenario with comprehensive planning (current)
    - `/research:dependencies` - Analyze required tools and dependencies if needed
    - `/research:prime` - Gather project context for contributor onboarding
    - `/plan:requirements` - Define specific requirements for the initialized work
    - Begin implementation with appropriate commands based on initialization type

    **Prerequisites:** Clear initialization goal or scenario defined
    **Next steps:** Follow initialization plan with specific implementation commands
    **Best timing:** Beginning of new projects, contributor onboarding, major feature starts
  </workflow>

  <examples>
    ```bash
    # Initialize new contributor onboarding
    /plan:init "new contributor onboarding"

    # Process: analyze project → create setup checklist → configure environment → establish workflow
    # Result: Complete onboarding plan with setup instructions and development workflow guidance
    ```

    ```bash
    # Initialize new project setup
    /plan:init "new React TypeScript project"

    # Process includes:
    # - Project structure planning with modern tooling requirements
    # - Development environment setup (Node.js, TypeScript, testing frameworks)
    # - Initial configuration files and project scaffolding
    # - Documentation template creation and development workflow establishment
    # - Integration with CI/CD and deployment pipeline setup planning
    ```

  </examples>
</instructions>
