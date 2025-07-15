# Research workflow

*Before coding: Research and understanding*

### Implementation memory consultation

**Check existing knowledge before external research:**

```bash
# First, check if we've implemented similar features before
# Look in .claude/memory/features/ for related work
# Review .claude/memory/patterns/ for established approaches
# Check .claude/memory/issues/ for known issues
```

**Memory consultation priorities:**

- Previous implementations of similar features and their outcomes.
- Project-specific patterns and architectural decisions.
- Known gotchas, performance characteristics, and edge cases.
- Security considerations discovered in past implementations.

### Documentation search workflow

**Always research before writing code:**

```bash
# Search for current best practices and implementation patterns.
mcp__ref__ref_search_documentation "[language/framework] [feature] best practices 2025"
mcp__ref__ref_search_documentation "[API/library name] documentation examples"
mcp__ref__ref_search_documentation "[technology] security considerations"

# Read the actual documentation from search results.
mcp__ref__ref_read_url "[documentation URL found in search]"
```

**Research priorities:**

- Current best practices and established patterns.
- Security implications and common vulnerabilities.
- Performance considerations and optimization strategies.
- Integration approaches with existing libraries.

### Required questions framework

**Ask questions early and often during requirements gathering to avoid assumptions. Use implementation memory to inform better questions.**

**Feature implementation:**
- "What exact user experience are you envisioning?"
- "Should this be configurable? What are sensible defaults?"
- "How should this integrate with existing features?"
- "Have we implemented similar patterns before? What worked/didn't work?"

**Error handling:**
- "What should happen when this operation fails?"
- "Should failed operations be retried automatically? How many times?"
- "What logging would help debug issues in production?"
- "What error patterns have we seen in similar implementations?"

**Performance:**
- "Are there specific performance constraints or SLAs?"
- "What's the acceptable response time range?"
- "What performance characteristics did similar features exhibit?"

**Security:**
- "What are the security implications of this change?"
- "Does this handle user data? What protection is needed?"
- "What data should never be logged or exposed?"
- "What security issues have we encountered in related implementations?"

**Maintenance:**
- "What testing strategy will verify this works correctly?"
- "What documentation needs to be created or updated?"
- "How will this be monitored and debugged in production?"
- "What maintenance challenges did similar features present?"

### Codebase analysis

**Before modifying any file, understand the existing context.**

```bash
# Check recent development context
git log --oneline -20

# Find related implementations across codebase
git grep "[feature-name]"

# Check current state
git status

# Review implementation memory for this project
ls .claude/memory/features/
ls .claude/memory/patterns/
```

**Analyze existing patterns:**
- Similar implementations and their approaches.
- Naming conventions and coding styles.
- Library choices and architectural decisions.
- Testing patterns and coverage approaches.
- Past implementation decisions and their rationale.

**Next step:** Once research is complete, proceed to @guidelines/planning-workflow.md for systematic problem analysis and planning.