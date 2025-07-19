# Validate performance and optimization effectiveness

<instructions>
  <context>
    Validate performance and optimization effectiveness for $ARGUMENTS through benchmarking, profiling, and load testing.
  </context>

  <requirements>
    - Access to performance testing tools and monitoring systems
    - Understanding of performance metrics and benchmarking
    - Ability to simulate realistic load and usage patterns
  </requirements>

  <execution>
    1. **Measure and profile**
       - Establish performance baselines and target metrics
       - Profile CPU, memory, and I/O usage patterns
       - Measure response times and throughput under load
       - Analyze database query performance

    2. **Load and stress testing**
       - Design realistic load testing scenarios
       - Execute stress tests to identify breaking points
       - Test performance under concurrent user loads
       - Validate auto-scaling and resource allocation
       - Test recovery and stability after load spikes

    3. **Validate and monitor**
       - Validate effectiveness of implemented optimizations
       - Compare metrics before and after changes
       - Test performance across different environments
       - Verify performance SLA compliance
       - Document performance characteristics and recommendations
  </execution>

  <validation>
    - [ ] Performance baselines established
    - [ ] CPU, memory, and I/O usage profiled
    - [ ] Load testing scenarios executed
    - [ ] Performance under concurrent loads validated
    - [ ] Optimization effectiveness measured
    - [ ] Performance SLA compliance verified
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