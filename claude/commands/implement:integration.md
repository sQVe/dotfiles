# Implement system integrations and API connections

<instructions>
  <context>
    Implement integration with external systems, APIs, or services for $ARGUMENTS ensuring reliable communication and proper error handling.
  </context>

  <requirements>
    - Integration specifications and API documentation
    - Understanding of authentication and security requirements
    - Access to testing tools and staging environments
  </requirements>

  <execution>
    1. **Ultrathink: Integration architecture and strategy**
       - Use sequential thinking to analyze $ARGUMENTS integration scope and design implementation approach
       - Break down integration components: authentication, data flow, error handling, monitoring, testing
       - Consider integration patterns: API clients, webhooks, data transformation, rate limiting, security
       - Plan implementation sequence prioritizing security, reliability, and maintainability

    2. **Analyze and plan integration**
       - Analyze API documentation and integration requirements
       - Plan authentication strategy and credential management
       - Design data mapping and transformation logic
       - Identify rate limiting and quota considerations

    3. **Implement with security**
       - Implement authentication and credential management
       - Create API client with proper error handling and retries
       - Add request/response validation and data sanitization
       - Implement rate limiting and circuit breaker patterns
       - Add logging for debugging and monitoring
       - Handle different response formats and error scenarios

    4. **Test and ensure reliability**
       - Create integration tests with mocked responses
       - Test authentication flows and token refresh
       - Validate error handling and fallback mechanisms
       - Test rate limiting and quota management
       - Verify data transformation and validation logic
       - Document integration setup and troubleshooting
  </execution>

  <validation>
    - [ ] API documentation analyzed and integration planned
    - [ ] Authentication and credential management implemented
    - [ ] API client with error handling and retries created
    - [ ] Rate limiting and circuit breaker patterns added
    - [ ] Request/response validation and sanitization implemented
    - [ ] Integration tests created and error scenarios tested
    - [ ] Integration documented with setup instructions
  </validation>

  <workflow>
    **Integration development workflow:**
    - `/research:external` - Research API documentation and best practices
    - `/research:codebase` - Understand existing integration patterns
    - `/plan:requirements` - Define integration requirements and scope
    - `/implement:integration` - Execute integration development (current)
    - `/validate:tests` - Test integration functionality and error handling
    - `/validate:security` - Validate security and authentication
    - `/validate:functionality` - Manual integration testing
    - `/finalize:commit` - Commit integration with documentation

    **Prerequisites:** API documentation, integration requirements defined
    **Next steps:** Comprehensive testing and security validation
    **Best practices:** Start with staging environment, comprehensive error handling
  </workflow>

  <examples>
    ```bash
    # Implement third-party API integration
    /implement:integration "Stripe payment processing API"

    # Process: analyze API → implement client → add security → testing → documentation
    # Result: Secure, tested integration with comprehensive error handling
    ```

    ```bash
    # Implement webhook integration
    /implement:integration "GitHub webhook for CI/CD triggers"

    # Process includes:
    # - Design webhook endpoint with signature verification
    # - Implement payload validation and event processing
    # - Add idempotency and duplicate event handling
    # - Create secure webhook URL and authentication
    # - Test webhook delivery and retry mechanisms
    # - Monitor webhook health and failure rates
    ```
  </examples>
</instructions>