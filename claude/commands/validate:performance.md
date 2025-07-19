# Validate performance benchmarks and optimization effectiveness

<instructions>
  <context>
    Validate performance characteristics and optimization effectiveness for $ARGUMENTS through comprehensive benchmarking, profiling, and load testing.
  </context>

  <requirements>
    - Access to performance testing tools and monitoring systems
    - Understanding of performance metrics and benchmarking methodologies
    - Ability to simulate realistic load and usage patterns
  </requirements>

  <execution>
    1. **Performance measurement and profiling**
       - Establish performance baselines and target metrics
       - Profile CPU, memory, and I/O usage patterns
       - Measure response times and throughput under load
       - Analyze database query performance and optimization

    2. **Load testing and stress testing**
       - Design realistic load testing scenarios
       - Execute stress tests to identify breaking points
       - Test performance under concurrent user loads
       - Validate auto-scaling and resource allocation
       - Measure performance degradation patterns
       - Test recovery and stability after load spikes

    3. **Optimization validation and monitoring**
       - Validate effectiveness of implemented optimizations
       - Compare performance metrics before and after changes
       - Test performance across different environments
       - Verify performance SLA compliance
       - Set up continuous performance monitoring
       - Document performance characteristics and recommendations
  </execution>

  <validation>
    - [ ] Performance baselines established and measured
    - [ ] CPU, memory, and I/O usage profiled
    - [ ] Load testing scenarios executed successfully
    - [ ] Performance under concurrent loads validated
    - [ ] Optimization effectiveness measured and documented
    - [ ] Performance SLA compliance verified
    - [ ] Continuous monitoring and alerting configured
  </validation>

  <workflow>
    **Part of validation workflow:**
    - `/validate:code` - Automated quality checks before performance testing
    - `/validate:tests` - Ensure functionality works before performance testing
    - `/validate:performance` - Performance benchmarking and load testing (current)
    - `/implement:optimization` - Address performance issues found
    - `/validate:functionality` - Verify optimizations don't break features

    **Prerequisites:** Feature complete and functionally tested
    **Next steps:** Address performance issues, re-test after optimizations
    **Best timing:** Before production deployment, after major changes
  </workflow>

  <examples>
    ```bash
    # Validate API performance
    /validate:performance "REST API endpoints under production load"

    # Process: baseline → profile → load test → validate → monitor
    # Result: Performance validation report with optimization recommendations
    ```

    ```bash
    # Validate frontend performance
    /validate:performance "web application Core Web Vitals"

    # Process includes:
    # - Measure page load times and render performance
    # - Test performance on different devices and networks
    # - Validate bundle size and loading optimization
    # - Check accessibility performance impact
    # - Monitor real user performance metrics
    # - Identify performance bottlenecks and improvements
    ```
  </examples>
</instructions>