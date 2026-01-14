---
name: review
description: Substantive code or writing review with parallel subagents
argument-hint: '[type] [scope]'
allowed-tools:
  - Read
  - Bash
  - Glob
  - Grep
  - Task
---

<objective>
Review code or writing for substantive issues: bugs, logic errors, edge cases, security issues, clarity problems.

Dispatches 3 parallel subagents with identical prompts. Each reviews independently, findings are deduplicated and compiled.
</objective>

<arguments>
- **type** (optional): `code` or `writing`. Auto-detects from file extensions if omitted.
- **scope** (optional): `unstaged`, `staged`, or file path. Defaults to all branch changes vs master.
</arguments>

<process>
1. **Determine scope**
   - No scope: `git diff master...HEAD` plus uncommitted changes
   - `unstaged`: `git diff` (working tree only)
   - `staged`: `git diff --staged`
   - Path: specified file(s)

2. **Detect review type**
   - Argument provided → use it
   - `.ts`, `.js`, `.py`, `.go`, etc. → code
   - `.md`, `.txt` → writing
   - Mixed → code

3. **Build subagent prompt** using `<subagent_prompt>` template

4. **Dispatch 3 subagents in parallel**
   - Use Task tool with 3 parallel invocations
   - For code: use `superpowers:code-reviewer` agent type
   - For writing: use general-purpose with elements-of-style context
   - Each gets identical prompt

5. **Compile findings**
   - Merge results from all agents
   - Deduplicate by: file + line + issue category (e.g., "null-check", "bounds", "sql-injection")
   - Keep the clearest description when merging duplicates
   - Note consensus (found by N agents)
   - Sort: Critical → Warning → Info

6. **Generate report** using `<report_format>`
</process>

<subagent_prompt>
<review_context>
<type>$REVIEW_TYPE</type>
<scope>$SCOPE_DESCRIPTION</scope>
</review_context>

<content_to_review>
$DIFF_OR_FILE_CONTENT
</content_to_review>

<review_focus>
For code: bugs, logic errors, edge cases, security issues, improvements
For writing: clarity, accuracy, structure, missing information
</review_focus>

<output_format>
Return findings as JSON array:

```json
[
  {
    "severity": "critical|warning|info",
    "file": "path/to/file.ts",
    "line": 42,
    "description": "Clear description of the issue"
  }
]
```

Severity guide:

- **critical**: Bugs, security issues, data loss risks
- **warning**: Logic gaps, edge cases, maintainability issues
- **info**: Improvements, suggestions, style (non-CLAUDE.md)
</output_format>
</subagent_prompt>

<report_format>

## Review: [type] - [scope]

### Critical (must fix)

- `file:line` — Description [found by N agents]

### Warning (should fix)

- `file:line` — Description

### Info (consider)

- `file:line` — Suggestion

### Summary

X critical, Y warnings, Z info items across N files
</report_format>

<success_criteria>

- [ ] Scope determined correctly
- [ ] Review type detected or used from argument
- [ ] 3 subagents dispatched in parallel
- [ ] Findings deduplicated and compiled
- [ ] Report generated with severity categories

</success_criteria>
