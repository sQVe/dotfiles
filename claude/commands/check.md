---
name: check
description: Check code against project rules and conventions
argument-hint: '[scope]'
model: claude-opus-4-5-20251101
allowed-tools:
  - Read
  - Bash
  - Glob
  - Grep
  - Task
---

<objective>
Check code against CLAUDE.md rules and project conventions. Checks style compliance, not logic or bugs.

Dispatches 2 parallel subagents with identical prompts. Each checks independently; violations are deduplicated and compiled.
</objective>

<arguments>
- **scope** (optional): `unstaged`, `staged`, or file path. Defaults to all branch changes vs master.
</arguments>

<context_injection>
Load these reference documents (if they exist):

- `~/.claude/CLAUDE.md` (global rules)
- `.claude/CLAUDE.md` or `CLAUDE.md` (project rules)
- `README.md` (project conventions)
- `CONTRIBUTING.md` (contribution guidelines)
</context_injection>

<process>
1. **Determine scope**
   - No scope: `git diff master...HEAD` plus uncommitted changes
   - `unstaged`: `git diff` (working tree only)
   - `staged`: `git diff --staged`
   - Path: specified file(s)

   **Verify complete coverage:**
   - Run `git diff --name-only [flags]` to list all affected files
   - Confirm the diff content includes every listed file
   - Report file count: "Checking N files"

2. **Load reference documents** per `<context_injection>`

3. **Build subagent prompt** using `<subagent_prompt>` template

4. **Dispatch 2 subagents in parallel**
   - Use Task tool with 2 parallel invocations
   - Each gets identical prompt with all reference docs

5. **Compile findings**
   - Merge results from both agents
   - Deduplicate by: file + line + rule identifier (e.g., "CLAUDE.md#typescript/nullish-coalescing")
   - Keep the clearest description when merging duplicates
   - Note source document for each rule

6. **Generate report** using `<report_format>`
</process>

<subagent_prompt>
<check_context>
<scope>$SCOPE_DESCRIPTION</scope>
</check_context>

<reference_documents>
$LOADED_REFERENCE_DOCS
</reference_documents>

<content_to_check>
$DIFF_OR_FILE_CONTENT
</content_to_check>

<check_focus>
Check for violations of rules defined in the reference documents:

- Code style rules (TypeScript conventions, patterns)
- Principles (minimal changes, single responsibility)
- Writing rules (concise, active voice, formatting)
</check_focus>

<output_format>
Return violations as JSON array:

```json
[
  {
    "rule": "Use ?? for defaults, not ||",
    "source": "CLAUDE.md",
    "file": "path/to/file.ts",
    "line": 42,
    "description": "Uses || where ?? is appropriate for nullish coalescing"
  }
]
```

Only flag clear violations. Do not flag subjective interpretations.
</output_format>
</subagent_prompt>

<report_format>
## Check: Project Rules Compliance

### Violations
1. `file:line` — **[rule]** (source) description
2. `file:line` — **[rule]** (source) description
3. `file:line` — **[rule]** (source) description

**Summary:** X files, Y violations

**Recommendation:** Fix 1, 3. Consider 2.

If no violations: ✓ All checks passed (X files)
</report_format>

<success_criteria>

- [ ] Scope determined correctly
- [ ] All changed files included (verified via --name-only)
- [ ] Reference documents loaded
- [ ] 2 subagents dispatched in parallel
- [ ] Violations deduplicated and compiled
- [ ] Report generated with rule sources

</success_criteria>
