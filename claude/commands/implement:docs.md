# Implement comprehensive documentation

<instructions>
  <context>
    Create comprehensive documentation for $ARGUMENTS through analysis of documentation needs and implementation of appropriate documentation strategies.
  </context>

  <requirements>
    - Understanding of documentation standards and best practices
    - Access to codebase and existing documentation structure
    - Knowledge of target audience and documentation types
    - Ability to write clear, maintainable documentation
  </requirements>

  <execution>
    1. **Quick analysis: Documentation scope and comprehensive strategy**
       - Analyze $ARGUMENTS and identify complete documentation requirements
       - Plan documentation types: API docs, user guides, inline comments, architecture
       - Determine optimal documentation approach and format standards

    2. **Documentation planning and structure**
       - Identify all components requiring documentation
       - Map user workflows and technical requirements
       - Plan documentation hierarchy and organization
       - Design consistent format following project conventions

    3. **Documentation implementation**
       - Write API documentation with examples and usage patterns
       - Create inline code comments explaining complex logic
       - Implement user guides and setup instructions
       - Document architecture decisions and design patterns
       - Add configuration and deployment documentation
       - Create troubleshooting and FAQ sections

    4. **Documentation validation and optimization**
       - Verify documentation accuracy and completeness
       - Validate examples work and instructions are clear
       - Optimize for readability and maintainability
       - Ensure documentation follows project style guidelines
  </execution>

  <validation>
    - [ ] API documentation complete with examples and usage
    - [ ] Inline code comments explain complex logic appropriately
    - [ ] User guides and setup instructions implemented
    - [ ] Architecture and design decisions documented
    - [ ] Configuration and deployment docs created
    - [ ] Examples tested and verified working
    - [ ] Documentation follows project style guidelines
    - [ ] Content organized logically for target audience
  </validation>

  <workflow>
    **Part of implementation workflow:**
    1. `/implement:feature` or `/implement:refactor` - Code implementation
    2. `/implement:docs` - Create comprehensive documentation (current)
    3. `/validate:docs` - Review documentation quality and accuracy
    4. `/validate:functionality` - Verify examples and instructions work
    5. `/finalize:commit` - Commit implementation with documentation

    **Prerequisites:** Feature/component implementation complete or in progress
    **Next steps:** Validate documentation accuracy and completeness
    **Best practices:** Write documentation during implementation for accuracy
  </workflow>

  <examples>
    ```bash
    # Implement documentation for authentication API
    /implement:docs "user authentication API endpoints"

    # Process: analyze scope → plan structure → implement comprehensive docs → validate
    # Result: Complete documentation suite for authentication API
    ```

    ```bash
    # Create documentation for new feature
    /implement:docs "payment processing module"

    # Process includes:
    # - API docs: endpoint specifications, request/response examples
    # - User guide: integration steps, usage patterns, best practices
    # - Inline comments: complex business logic, security considerations
    # - Architecture: design decisions, data flow, error handling
    # - Configuration: environment setup, required settings
    # - Troubleshooting: common issues, debugging steps
    ```

    ```bash
    # Example documentation implementation results
    # ✅ API Documentation (docs/api/payment.md)
    #   - Endpoint specifications with request/response schemas
    #   - Authentication requirements and examples
    #   - Error codes and handling instructions
    # 
    # ✅ User Guide (docs/guides/payment-integration.md)
    #   - Step-by-step integration instructions
    #   - Code examples in multiple languages
    #   - Best practices and security considerations
    # 
    # ✅ Inline Documentation
    #   - Complex business logic commented appropriately
    #   - Public API methods with JSDoc/docstring format
    #   - Configuration options documented
    # 
    # ✅ Architecture Documentation (docs/architecture/payment-flow.md)
    #   - System design and data flow diagrams
    #   - Integration points and dependencies
    #   - Security model and compliance notes
    # 
    # 📋 Next steps:
    #   - Run /validate:docs to verify accuracy
    #   - Test all code examples for correctness
    ```

  </examples>
</instructions>