# Create detailed implementation workflow for complex features

<instructions>
  <context>
    Create step-by-step implementation workflow for $ARGUMENTS based on synthesized research and requirements to guide complex feature development with clear milestones and validation points.
  </context>

  <requirements>
    - Completed synthesis with technical decisions and implementation plan
    - Understanding of project complexity and development patterns
    - Clear feature scope and implementation requirements
    - Access to team collaboration and project management tools
  </requirements>

  <execution>
    1. **Ultrathink: Workflow planning and execution strategy**
       - Use sequential thinking to analyze $ARGUMENTS implementation scope and plan comprehensive workflow strategy
       - Break down workflow elements: task breakdown, dependency mapping, milestone planning, team coordination, risk management
       - Consider workflow methodologies: agile planning, critical path analysis, parallel development, quality gates, progress tracking
       - Plan systematic workflow development sequence ensuring realistic timelines and efficient execution

    2. **Workflow scope and milestone planning**
       - Verify $ARGUMENTS is provided (feature or implementation scope required)
       - If no argument provided, show error: "Please specify feature for workflow planning (e.g., 'payment integration', 'user dashboard redesign')"
       - Break down synthesized implementation plan into discrete, manageable tasks
       - Define clear milestones with deliverables and validation criteria
       - Identify task dependencies and critical path for implementation
       - Plan parallel development opportunities and team coordination points

    3. **Detailed task specification and sequencing**
       - Create specific, actionable tasks with clear acceptance criteria
       - Sequence tasks to minimize blocking dependencies and maximize parallel work
       - Define validation checkpoints and quality gates for each milestone
       - Specify required tools, environments, and resources for each task
       - Plan code review points and collaboration touchpoints
       - Identify risk mitigation strategies and contingency plans

    4. **Workflow documentation and team coordination**
       - Document complete workflow with task ownership and timelines
       - Create workflow visualization with dependencies and critical path
       - Plan communication cadence and progress tracking mechanisms
       - Define escalation paths and decision-making processes
       - Prepare workflow for team review and refinement
       - Connect workflow to appropriate command sequences for execution
  </execution>

  <validation>
    - [ ] Feature scope clearly defined and implementation plan reviewed
    - [ ] Complex implementation broken down into manageable, discrete tasks
    - [ ] Clear milestones with deliverables and validation criteria defined
    - [ ] Task dependencies and critical path identified
    - [ ] Parallel development opportunities and team coordination planned
    - [ ] Specific acceptance criteria and quality gates specified
    - [ ] Risk mitigation strategies and contingency plans included
    - [ ] Complete workflow documentation with visualization created
    - [ ] Team coordination and communication processes defined
  </validation>

  <workflow>
    **Prerequisites for workflow planning:**
    - `/plan:synthesis` - Technical decisions and implementation approach finalized
    - `/research:*` - All necessary research completed and consolidated
    - `/plan:requirements` - Clear requirements and constraints defined

    **After workflow creation:**
    - Team review and workflow refinement
    - Begin implementation using defined task sequence
    - `/implement:*` commands guided by workflow task specifications
    - Progress tracking and milestone validation
  </workflow>

  <examples>
    ```bash
    # Create workflow for complex feature implementation
    /plan:workflow "payment processing integration"

    # Process: analyze synthesis → break into tasks → sequence → document → coordinate
    # Result: Detailed implementation workflow with milestones and team coordination
    ```

    ```bash
    # Example: E-commerce checkout workflow
    /plan:workflow "checkout flow redesign"

    # Process includes:
    # - Milestone 1: Backend API design and implementation (3 tasks)
    # - Milestone 2: Frontend component development (5 tasks, parallel)
    # - Milestone 3: Integration and testing (4 tasks, sequential)
    # - Milestone 4: Performance optimization and deployment (2 tasks)
    # - Risk mitigation: Payment gateway fallback, user experience testing
    # - Team coordination: Daily standups, code review checkpoints
    ```

  </examples>
</instructions>