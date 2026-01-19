---
name: review
description: Substantive code or writing review with parallel subagents
argument-hint: '[type] [scope]'
model: claude-opus-4-5-20251101
allowed-tools:
  - Read
  - Bash
  - Glob
  - Grep
  - Task
---

<objective>
Review code or writing for substantive issues: bugs, logic errors, edge cases, security issues, clarity problems.

Dispatches 3 parallel subagents with identical prompts. Each reviews independently; findings are deduplicated and compiled.
</objective>

<arguments>
- **type** (optional): `code` or `writing`. Auto-detects from file extensions if omitted.
- **scope** (optional): `unstaged`, `staged`, or file path. Defaults to branch changes (vs main branch) plus uncommitted changes.
</arguments>

<process>
1. **Determine scope**
   - Detect main branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'` (fallback: `main`, then `master`)
   - No scope: `git diff $(git merge-base HEAD $MAIN_BRANCH)..HEAD` plus uncommitted changes
   - `unstaged`: `git diff` (working tree only)
   - `staged`: `git diff --staged`
   - Path: specified file(s)

   **Verify complete coverage:**
   - Run `git diff --name-only [flags]` to list all affected files
   - Confirm the diff content includes every listed file
   - Report file count: "Reviewing N files"

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
   - Deduplicate by: file + line range overlap
   - When findings overlap, merge descriptions and keep highest severity
   - Note consensus (found by N agents)
   - Sort: Critical → Warning → Info

6. **Generate report** using `<report_format>`

7. **Confirm action** (if issues found)
   - Use `AskUserQuestion` with options:
     - **Fix all** — apply all recommended fixes
     - **Fix selected** — choose which issues to fix
     - **Skip** — leave issues unfixed
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

### Critical
1. `file:line` — Description [found by N]

### Warning
2. `file:line` — Description [found by N]
3. `file:line` — Description [found by N]

### Info
4. `file:line` — Suggestion [found by N]

**Summary:** X critical, Y warnings, Z info across N files

**Recommendation:** Fix 1-2. Consider 3. Skip 4.
</report_format>

<success_criteria>

- [ ] Scope determined correctly
- [ ] All changed files included (verified via --name-only)
- [ ] Review type detected or used from argument
- [ ] 3 subagents dispatched in parallel
- [ ] Findings deduplicated and compiled
- [ ] Report generated with severity categories
- [ ] User chose action for issues (if any)

</success_criteria>
