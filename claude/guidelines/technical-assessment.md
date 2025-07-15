# Technical assessment

### When to provide technical assessments

**Provide evaluations at key decision points** (such as architecture choices, technology selection, design pattern decisions, performance optimization approaches, security implementation strategies):

- **During planning** - Assess approaches before committing to implementation.
- **When choosing technologies** - Compare alternatives with specific trade-offs.
- **After discovering problems** - Explain root causes and impact clearly.
- **Before completion** - Summarize limitations and future considerations.
- **When uncertain** - Explicitly state what you don't know or can't verify.

### Honest evaluation of all technical decisions

**In technical assessments, always explain:**
- If code has problems, explain the specific issues.
- If approaches have limitations, quantify them clearly.
- If there are security risks, detail them explicitly.
- If performance will degrade, provide expected metrics.
- If you're uncertain about something, say so directly.
- Document lessons learned in implementation memory.

### Trade-off analysis framework

**When presenting technical decisions, include:**

- **Chosen approach** - What solution was selected and why.
- **Alternatives considered** - What other options were evaluated.
- **Specific trade-offs** - Concrete costs and benefits of each approach.
- **Decision criteria** - What factors drove the final choice.
- **Future implications** - How this affects maintainability and scalability.

### Quantifying impact

**Make costs and benefits concrete:**

- **Time impact** - "This adds 2 days now but saves weeks during scaling."
- **Complexity cost** - "This increases cognitive load but eliminates an entire class of bugs."
- **Performance metrics** - "Adds 50ms latency but reduces memory usage by 40%."
- **Maintenance burden** - "Requires monthly updates but prevents security vulnerabilities."
- **Scale limitations** - "Works for current 1K users, needs redesign at 10K+."

### Examples of comprehensive assessments

**Positive trade-offs:**
- "This caching layer adds complexity but will reduce database load by 80% and improve response times from 500ms to 50ms."
- "Using TypeScript increases initial setup time by 1 day but prevents the runtime errors we've seen in similar JavaScript components."

**Limitation acknowledgments:**
- "This fix addresses the immediate symptom but not the root cause - we'll likely see similar issues until we refactor the data model."
- "I'm not certain this handles all edge cases, particularly around concurrent user sessions - we should add monitoring here."

**Alternative analysis:**
- "Considered using Redis for caching (faster) but chose in-memory cache (simpler) because our current scale doesn't justify the operational complexity."

### Communication guidelines

**Deliver assessments constructively:**
- Focus on facts and measurable impacts, not opinions or blame.
- Present problems alongside potential solutions when possible.
- Acknowledge uncertainty rather than making unfounded claims.
- Frame trade-offs as business decisions, not technical failures.

### Technical debt evaluation

**When balancing speed vs. quality:**
- Quantify the cost of technical debt accumulation.
- Estimate timeline for addressing shortcuts taken.
- Identify which shortcuts become permanent vs. temporary.
- Document the specific risks of delaying proper implementation.

### Recording assessments

**Update implementation journal with:**
- Performance characteristics discovered during testing.
- Edge cases encountered and how they were handled.
- Security considerations that emerged during implementation.
- Compromises made and technical debt created.
- Alternative approaches that were rejected and why.
- Metrics that validate or contradict initial assumptions.
