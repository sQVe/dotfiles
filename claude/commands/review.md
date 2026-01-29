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
  - Edit
  - Write
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

2. **Determine scope and gather content**
   - Detect main branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'` (fallback: `main`, then `master`)
   - No scope: changes from merge-base plus uncommitted
   - `unstaged`: `git diff` (working tree only)
   - `staged`: `git diff --staged`
   - Path: specified file(s)

   **Gather full context:**
   - Run `git diff --name-only [flags]` to list all affected files
   - If no files found: "No changes found for scope: {scope}"
   - For each changed file:
     - Read full file content (not just diff)
     - Get diff hunks for that file
   - Report: "Reviewing N files with 3 parallel agents..."

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
   - Deduplicate by: file + line range overlap (start_line/end_line)
   - When findings overlap, merge descriptions and keep highest severity
   - Note consensus (found by N agents)
   - Sort: Critical → Suggestion → Nitpick

7. **Generate report** (OUTPUT GATE)
   - Generate report using `<report_format>`
   - End output with `---` separator
   - **PROHIBITED after separator:**
     - "Let me...", "I'll...", "Now I will..."
     - "Starting with...", "First I'll..."
     - Any action-announcing language
   - Proceed directly to Confirm step

8. **Confirm action** (if issues found)
   - IMMEDIATELY use `AskUserQuestion` with options:
     - **Fix all** — apply all recommended fixes
     - **Fix selected** — choose which issues to fix
     - **Skip** — leave issues unfixed

<anti_patterns>
After presenting findings, NEVER:
- "Let me create/start/begin..."
- "I'll now..."
- "Starting with the first..."
- "Now I will..."
- Announcing intent before user chooses action
</anti_patterns>
</process>

<subagent_prompt>
<review_context>
<type>$REVIEW_TYPE</type>
<scope>$SCOPE_DESCRIPTION</scope>
<changed_files>$FILE_LIST</changed_files>
</review_context>

<content_to_review>
<!-- Each file includes FULL CONTENT plus diff hunks -->
<file path="$FILE_PATH">
<full_content>
$FULL_FILE_CONTENT
</full_content>
<diff>
$DIFF_HUNKS
</diff>
</file>
<!-- Repeat for each changed file -->
</content_to_review>

<review_focus>
For code: bugs, logic errors, edge cases, security issues, improvements
For writing: clarity, accuracy, structure, missing information
</review_focus>

<context_awareness>
You have FULL FILE CONTENT, not just diffs. Before flagging an issue:
- Check if validation/handling exists elsewhere in the file
- Check if the suggested fix already exists (don't add what's there)
- Understand framework behavior (e.g., Next.js notFound() throws, React hooks rules)
- Look at imports to understand available utilities and patterns
- Consider parent/child component relationships visible in the file
</context_awareness>

<output_format>
Return findings as JSON array:

```json
[
  {
    "severity": "critical|suggestion|nitpick",
    "file": "path/to/file.ts",
    "start_line": 42,
    "end_line": 45,
    "description": "Clear description of the issue",
    "suggestion": "How to fix it"
  }
]
```

Severity guide:

- **critical**: Bugs, security issues, data loss risks
- **suggestion**: Logic gaps, edge cases, better approaches
- **nitpick**: Style issues, naming, minor improvements

For single-line findings, `start_line` and `end_line` are the same.
Return empty array `[]` if no issues found.
</output_format>

<success_criteria>
- [ ] Reviewed all files in scope
- [ ] Used full file context to verify issues exist
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

### 💡 Suggestion

| #   | File       | Line | Issue                  | Consensus |
| --- | ---------- | ---- | ---------------------- | --------- |
| 2   | `utils.ts` | 15   | Unchecked null access  | 2/3       |
| 3   | `api.ts`   | 88   | Missing error handling | 2/3       |

### 📝 Nitpick

| #   | File        | Line | Suggestion                   | Consensus |
| --- | ----------- | ---- | ---------------------------- | --------- |
| 4   | `config.ts` | 5    | Consider extracting constant | 1/3       |

**Summary:** {critical_count} critical, {suggestion_count} suggestions, {nitpick_count} nitpicks across {file_count} files

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

`/lint staged` — verify fixes comply with project rules

---

**Also available:**

- `/commit` — commit after fixing
- `/pr` — create pull request when ready

---

</report_format>

<success_criteria>
- [ ] Scope determined correctly
- [ ] Full file content retrieved for all changed files
- [ ] Review type detected or used from argument
- [ ] 3 subagents dispatched in parallel with identical prompts
- [ ] Findings deduplicated with consensus tracking
- [ ] Report generated with severity categories and consensus
- [ ] User chose action for issues (if any)
</success_criteria>
