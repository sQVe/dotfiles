# Implement performance optimizations and improvements

<instructions>
  <context>
    Implement performance optimizations for $ARGUMENTS based on profiling data and performance analysis to improve system efficiency and user experience.
  </context>

  <requirements>
    - Performance profiling data and bottleneck identification
    - Understanding of optimization techniques and trade-offs
    - Access to performance testing tools and monitoring
  </requirements>

  <execution>
    1. **Ultrathink: Optimization strategy and approach**
       - Use sequential thinking to analyze $ARGUMENTS optimization scope and plan systematic performance improvement approach
       - Break down optimization areas: algorithms, data structures, caching, database, network, frontend performance
       - Consider optimization techniques: profiling analysis, bottleneck identification, impact measurement, implementation priorities
       - Plan optimization sequence balancing performance gains, implementation effort, and risk assessment

    2. **Performance analysis and profiling**
       - Verify $ARGUMENTS is provided (optimization target and goals required)
       - If no argument provided, show error: "Please specify optimization target (e.g., 'database query performance')"
       - Profile current performance and identify bottlenecks
       - Analyze resource usage patterns and constraints
       - Measure baseline performance metrics and user experience
       - Identify optimization opportunities and potential impact

    3. **Implementation of optimizations**
       - Implement targeted optimizations based on profiling data
       - Optimize database queries, indexes, and data access patterns
       - Improve algorithm efficiency and data structure usage
       - Add caching strategies and memoization where appropriate
       - Optimize network requests and reduce payload sizes
       - Implement lazy loading and code splitting techniques

    4. **Validation and monitoring**
       - Measure performance improvements against baseline
       - Validate that optimizations don't introduce regressions
       - Test performance under different load conditions
       - Add performance monitoring and alerting
       - Document optimization techniques and rationale
       - Create performance benchmarks for future reference
  </execution>

  <validation>
    - [ ] Performance baseline measured and bottlenecks identified
    - [ ] Targeted optimizations implemented based on data
    - [ ] Database queries and data access optimized
    - [ ] Caching strategies and lazy loading implemented
    - [ ] Performance improvements measured and validated
    - [ ] No regressions introduced in functionality
    - [ ] Performance monitoring and alerting added
    - [ ] Optimization techniques documented
  </validation>

  <workflow>
    **Optimization implementation workflow:**
    - `/debug:performance` - Identify bottlenecks and analyze performance first
    - `/research:external` - Research optimization patterns and techniques
    - `/implement:optimization` - Execute performance improvements (current)
    - `/validate:performance` - Measure improvements and verify success
    - `/validate:tests` - Ensure optimizations don't break functionality

    **Prerequisites:** Performance analysis completed, bottlenecks identified
    **Next steps:** Performance validation and testing
    **Complements:** `/debug:performance` for analysis, `/validate:code` for quality checks
  </workflow>

  <examples>
    ```bash
    # Optimize database performance
    /implement:optimization "API response time for user dashboard"

    # Process: profile → identify bottlenecks → optimize → measure → monitor
    # Result: Measurable performance improvements with monitoring in place
    ```

    ```bash
    # Optimize frontend performance
    /implement:optimization "page load time and bundle size"

    # Process includes:
    # - Analyze bundle size and loading performance
    # - Implement code splitting and lazy loading
    # - Optimize images and static assets
    # - Add service worker for caching
    # - Measure Core Web Vitals improvements
    # - Set up performance monitoring and budgets
    ```
  </examples>
</instructions>