# Profile Command

Perform systematic performance analysis to identify bottlenecks and optimization opportunities using profiling tools.

## Usage

```
/profile <performance-issue-description>
```

## Instructions

You are helping analyze performance issues to identify bottlenecks and optimization opportunities.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Strategic performance analysis**
   - Use ultrathink analysis to form bottleneck hypotheses across system layers, guiding all subsequent steps
   - Prioritize profiling areas by performance impact and measurement feasibility
   - Focus on the most likely culprits: database queries, hot code paths, memory leaks

3. **Identify available profiling tools and metrics**
   - Discover existing performance monitoring tools and dashboards
   - Check for profiling libraries, APM tools, and performance testing frameworks
   - Identify available metrics: CPU usage, memory consumption, database query times, network latency

4. **Establish performance baseline and scope**
   - Define performance targets and acceptable thresholds
   - Identify specific components, endpoints, or workflows to profile
   - Gather historical performance data for comparison
   - Document current system specifications and load conditions

5. **Execute comprehensive profiling**
   - **CPU**: Identify hot code paths and excessive CPU usage
   - **Memory**: Detect leaks, excessive allocations, and GC issues
   - **Database**: Analyze slow queries and connection efficiency
   - **Network**: Measure API response times and service latency
   - **Application**: Profile specific algorithms and data workflows

6. **Analyze bottlenecks and root causes**
   - **Performance patterns**: Identify recurring issues and peak load conditions
   - **Resource constraints**: Determine if CPU, memory, I/O, or network-bound
   - **Code inefficiencies**: Locate algorithmic complexity and optimization opportunities
   - **Infrastructure limits**: Assess database capacity and service dependencies

7. **Generate comprehensive performance report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include profiling data: Measurements, metrics, and benchmark results
   - Document bottlenecks: Exact locations and components causing issues
   - Provide optimization recommendations: Prioritized improvements with expected gains
   - Add implementation guidance: Code changes, config updates, infrastructure modifications

## Examples

```bash
# Analyze API response time issues
/profile "API response times degraded after recent changes"

# Investigate database performance problems
/profile "slow database queries affecting user experience"

# Profile memory usage and garbage collection
/profile "high memory consumption and frequent GC pauses"

# Analyze frontend performance bottlenecks
/profile "slow page load times and poor user experience"
```
