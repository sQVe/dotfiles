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
1. **Validate prerequisites**
   - Run `git rev-parse --git-dir` — if fails: "Not a git repository"
   - If validation fails: stop with clear message

2. **Determine scope**
   - Detect main branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'` (fallback: `main`, then `master`)
   - No scope: `git diff $(git merge-base HEAD $MAIN_BRANCH)..HEAD` plus uncommitted changes
   - `unstaged`: `git diff` (working tree only)
   - `staged`: `git diff --staged`
   - Path: specified file(s)

   **Verify complete coverage:**
   - Run `git diff --name-only [flags]` to list all affected files
   - If no files found: "No changes found for scope: {scope}"
   - Confirm the diff content includes every listed file
   - Report file count: "Reviewing N files"

3. **Detect review type**
   - Argument provided → use it
   - `.ts`, `.js`, `.py`, `.go`, etc. → code
   - `.md`, `.txt` → writing
   - Mixed → code

4. **Build subagent prompt** using `<subagent_prompt>` template

5. **Dispatch 3 subagents in parallel**
   - Output before spawning: "Reviewing {N} files for {type} issues with 3 parallel agents..."
   - Use Task tool with 3 parallel invocations
   - For code: use `superpowers:code-reviewer` agent type
   - For writing: use general-purpose with elements-of-style context
   - Each gets identical prompt

6. **Compile findings**
   - Merge results from all agents
   - Deduplicate by: file + line range overlap
   - When findings overlap, merge descriptions and keep highest severity
   - Note consensus (found by N agents)
   - Sort: Critical → Warning → Info

7. **Generate report** using `<report_format>`

8. **Confirm action** (if issues found)
   - Use `AskUserQuestion` with options: - **Fix all** — apply all recommended fixes - **Fix selected** — choose which issues to fix - **Skip** — leave issues unfixed
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

<success_criteria>

- [ ] Reviewed all files in scope
- [ ] Identified bugs, logic errors, and security issues
- [ ] Returned valid JSON matching schema
- [ ] Each finding has clear severity and description
      </success_criteria>
      </subagent_prompt>

<report_format>

## Review: {type} — {scope}

**Scope:** {scope_description}
**Files reviewed:** {file_count}
**Agents:** 3 parallel

### 🛑 Critical

| #   | File      | Line | Issue                       | Consensus |
| --- | --------- | ---- | --------------------------- | --------- |
| 1   | `auth.ts` | 42   | SQL injection vulnerability | 3/3       |

### ⚠️ Warning

| #   | File       | Line | Issue                  | Consensus |
| --- | ---------- | ---- | ---------------------- | --------- |
| 2   | `utils.ts` | 15   | Unchecked null access  | 2/3       |
| 3   | `api.ts`   | 88   | Missing error handling | 2/3       |

### ℹ️ Info

| #   | File        | Line | Suggestion                   | Consensus |
| --- | ----------- | ---- | ---------------------------- | --------- |
| 4   | `config.ts` | 5    | Consider extracting constant | 1/3       |

**Summary:** {critical_count} critical, {warning_count} warnings, {info_count} info across {file_count} files

**Recommendation:** Fix 1-2 (high consensus). Consider 3. Skip 4.

If no issues:

```
✓ No issues found

Scope: {scope_description}
Files: {file_count} reviewed by 3 agents
```

---

## ▶ Next Up

**Fix critical issues** — address high-severity findings first

`/check staged` — verify fixes comply with project rules

---

**Also available:**

- `/commit` — commit after fixing
- `/pr` — create pull request when ready

---

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
