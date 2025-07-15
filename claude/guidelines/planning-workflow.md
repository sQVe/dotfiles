# Planning workflow

_During problem solving: Analysis and planning_

### Sequential thinking for complex problems

**Use Sequential Thinking MCP for systematic problem analysis:**

- Break down complex problems into manageable steps
- Analyze multiple approaches and trade-offs systematically
- Work through decision trees and dependencies
- Revise and refine analysis as understanding evolves
- Generate and validate solution hypotheses

**When to use sequential thinking:**

- Feature implementations (even "simple" ones have edge cases)
- Debugging complex issues (systematic analysis beats guessing)
- Architecture decisions (consider all implications)
- Performance optimizations (measure, analyze, implement)
- Security implementations (threat model first)
- Refactoring plans (understand current state fully)

**Planning methodology:**

- **Plan in concrete steps, not timeframes:**
  - ❌ "Week 1: Implement authentication"
  - ✅ "Step 1: Create user model with password hashing"
  - ✅ "Step 2: Implement JWT token generation"
- **Steps are actionable and measurable** - not time estimates.
- **Consider error cases and edge conditions** early.
- **Plan for testing and validation** at each step.
- **Identify dependencies and prerequisites** before starting.
- **Reference past implementation patterns and gotchas** during analysis.

### Decision documentation during planning

**Document key decisions as you make them:**

- **Architecture choices** - Why this approach over alternatives.
- **Technology selections** - Rationale for library/framework choices.
- **Security considerations** - Threat model and mitigation strategies.
- **Performance trade-offs** - Expected characteristics and bottlenecks.
- **Integration approach** - How this fits with existing systems
