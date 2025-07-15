# Research workflow

*Before coding: Research and understanding*

### Previous work consultation

**Check existing knowledge before external research:**

- Review previous implementations of similar features and their outcomes
- Look for project-specific patterns and architectural decisions
- Check for known gotchas, performance characteristics, and edge cases
- Consider security considerations discovered in past implementations

### Documentation search workflow

**Use Ref MCP for technical research:**

- Technical documentation and API references
- Framework-specific best practices and patterns
- Security considerations for specific technologies
- Integration examples and code samples

**Effective search strategies:**

- Search for specific topics: "[language] [API] documentation examples"
- Find best practices: "[framework] security best practices"
- Research patterns: "[library] integration patterns"
- Follow up by reading full documentation URLs from results

**When to research:**

- Before starting implementation (understand established patterns)
- When encountering unfamiliar APIs or libraries
- Before making architectural decisions
- When debugging complex or unusual issues

**Research priorities:**

- Current best practices and established patterns
- Security implications and common vulnerabilities
- Performance considerations and optimization strategies
- Integration approaches with existing libraries

### Required questions framework

**Ask questions early and often during requirements gathering to avoid assumptions:**

**Feature implementation:**
- "What exact user experience are you envisioning?"
- "Should this be configurable? What are sensible defaults?"
- "How should this integrate with existing features?"
- "Have we implemented similar patterns before? What worked/didn't work?"

**Error handling:**
- "What should happen when this operation fails?"
- "Should failed operations be retried automatically? How many times?"
- "What logging would help debug issues in production?"

**Performance:**
- "Are there specific performance constraints or SLAs?"
- "What's the acceptable response time range?"

**Security:**
- "What are the security implications of this change?"
- "Does this handle user data? What protection is needed?"
- "What data should never be logged or exposed?"

**Maintenance:**
- "What testing strategy will verify this works correctly?"
- "What documentation needs to be created or updated?"
- "How will this be monitored and debugged in production?"

### Codebase analysis

**Before modifying any file, understand the existing context:**

- Check recent development activity and changes
- Find similar implementations across the codebase
- Review current project state and any ongoing work
- Look for relevant patterns and decisions from past work

**Analyze existing patterns:**
- Similar implementations and their approaches
- Naming conventions and coding styles
- Library choices and architectural decisions
- Testing patterns and coverage approaches
- Past implementation decisions and their rationale

### Production issue investigation

**Use Sentry MCP for debugging live problems:**

- Find and analyze production errors and crashes
- Search for specific error types, timeframes, or affected users
- Understand error patterns and frequency trends
- Get detailed stack traces and context for debugging
- Identify root causes with AI-powered analysis

**When to investigate:**
- Users report unexpected behavior or errors
- Monitoring alerts indicate performance degradation
- New deployments show increased error rates
- Need to understand error patterns before fixes
