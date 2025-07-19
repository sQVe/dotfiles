# Identify and analyze performance bottlenecks

<instructions>
  <context>
    Analyze performance bottlenecks and optimization opportunities for $ARGUMENTS using profiling tools and performance analysis.
  </context>

  <requirements>
    - Performance issue description or component to analyze
    - Access to profiling tools and performance monitoring
    - Understanding of application architecture and critical paths
  </requirements>

  <execution>
    1. **Ultrathink: Performance analysis strategy**
       - Use sequential thinking to analyze $ARGUMENTS performance scope and identify investigation approach
       - Break down performance domains: frontend/backend, CPU/memory/I/O, user-facing/system metrics
       - Consider measurement angles: baseline metrics, profiling tools, load conditions, optimization opportunities
       - Plan performance analysis sequence prioritizing highest-impact areas

    2. **Establish baseline and identify critical paths**
       - Measure baseline performance metrics for $ARGUMENTS
       - Identify critical performance paths and user-facing workflows
       - Gather current performance data and user-reported symptoms

    3. **Profile and identify bottlenecks**
       - Use profiling tools to identify CPU, memory, and I/O bottlenecks
       - Analyze database query performance and execution plans
       - Profile network requests, API calls, and external dependencies
       - Identify algorithmic inefficiencies and resource usage patterns
       - Measure performance across different load conditions

    4. **Recommend optimizations with impact analysis**
       - Prioritize bottlenecks by performance impact and implementation effort
       - Research optimization techniques for identified issues
       - Recommend specific strategies with expected performance gains
       - Create actionable optimization plan with measurable success criteria
  </execution>

  <validation>
    - [ ] Performance baseline established and critical paths identified
    - [ ] Profiling completed using appropriate tools
    - [ ] Specific bottlenecks identified with supporting data
    - [ ] Optimization opportunities prioritized by impact vs effort
    - [ ] Actionable recommendations provided with expected gains
  </validation>

  <workflow>
    **Performance debugging workflow:**
    - `/debug:performance` - Identify bottlenecks and analyze performance (current)
    - `/research:external` - Research optimization patterns for identified issues
    - `/implement:optimization` - Implement performance improvements
    - `/validate:performance` - Measure improvements and verify success

    **Prerequisites:** Performance issues or degradation observed
    **Next steps:** Implementation of identified optimizations
    **Complements:** `/debug:analyze` for functional issues, `/debug:production` for production-specific problems
  </workflow>

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
