# Identify and analyze performance bottlenecks systematically

<instructions>
  <context>
    Analyze performance bottlenecks and optimization opportunities for $ARGUMENTS using profiling tools and systematic performance analysis.
  </context>

  <requirements>
    - Performance issue description or component to analyze
    - Access to profiling tools and performance monitoring
    - Development environment with performance measurement capabilities
    - Understanding of application architecture and critical paths
  </requirements>

  <execution>
    1. **Performance issue analysis and baseline measurement**
       - Verify $ARGUMENTS is provided (performance issue or component to analyze required)
       - If no argument provided, show error: "Please specify what to analyze (e.g., 'API response times', 'page load performance', 'database queries')"
       - Establish baseline performance metrics for $ARGUMENTS
       - Identify critical performance paths and user-facing workflows
       - Gather current performance data and user-reported symptoms

    2. **Systematic profiling and bottleneck identification**
       - Use profiling tools to identify CPU, memory, and I/O bottlenecks
       - Analyze database query performance and execution plans
       - Profile network requests, API calls, and external service dependencies
       - Identify algorithmic inefficiencies and resource usage patterns
       - Measure performance across different load conditions and data sizes

    3. **Optimization recommendations and impact analysis**
       - Prioritize bottlenecks by performance impact and implementation effort
       - Research current performance optimization techniques for identified issues
       - Recommend specific optimization strategies with expected performance gains
       - Estimate implementation effort and potential risks for each optimization
       - Create actionable optimization plan with measurable success criteria

  </execution>

  <validation>
    - [ ] Performance issue scope clearly defined with baseline measurements
    - [ ] Critical performance paths and workflows identified
    - [ ] Systematic profiling completed using appropriate tools
    - [ ] Specific bottlenecks identified with supporting performance data
    - [ ] Optimization opportunities prioritized by impact versus effort
    - [ ] Actionable recommendations provided with expected performance gains
    - [ ] Implementation plan created with measurable success criteria
  </validation>

  <examples>
    ```bash
    # Analyze API performance bottlenecks
    /debug:performance "API response times degraded after recent changes"

    # Process: baseline measurement → profiling → bottleneck identification → optimization recommendations
    # Result: Specific performance issues identified with prioritized optimization plan
    ```

    ```bash
    # Analyze database performance issues
    /debug:performance "slow database queries affecting user experience"

    # Process includes:
    # - Query execution plan analysis and index utilization review
    # - Database profiling to identify N+1 queries and inefficient joins
    # - Load testing under different data volumes and concurrent users
    # - Optimization recommendations: indexing, query rewriting, caching strategies
    # - Implementation plan with expected query time improvements
    ```

  </examples>
</instructions>
