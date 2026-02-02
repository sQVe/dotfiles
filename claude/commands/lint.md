---
name: lint
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
- **scope** (optional): `unstaged`, `staged`, or file path. Defaults to all branch changes (vs main branch) plus staged and unstaged changes.
</arguments>

<context_injection>
Load these reference documents (if they exist):

- `~/.claude/CLAUDE.md` (global rules)
- `.claude/CLAUDE.md` or `CLAUDE.md` (project rules)
- `README.md` (project conventions)
- `CONTRIBUTING.md` (contribution guidelines)
  </context_injection>

<process>
1. **Validate prerequisites**
   - Run `git rev-parse --git-dir` — if fails: "Not a git repository"
   - Check at least one reference document exists per `<context_injection>`
   - If no reference documents found: "No CLAUDE.md or project guidelines found"
   - If validation fails: stop with clear message

2. **Determine scope**
   - Detect main branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'` (fallback: `main`, then `master`)
   - No scope: Branch changes plus uncommitted
     ```bash
     # Branch changes (committed since diverging from main)
     git diff $(git merge-base HEAD $MAIN_BRANCH)..HEAD
     # Uncommitted changes (staged + unstaged)
     git diff
     # Combined: concatenate outputs
     ```
   - `unstaged`: `git diff` (working tree only)
   - `staged`: `git diff --staged`
   - Path: specified file(s)

   **Verify scope captured all files:**
   - Run `git diff --name-only [flags]` to list affected files
   - If no files found: "No changes found for scope: {scope}"
   - Report file count: "Checking N files"

3. **Load reference documents** per `<context_injection>`

4. **Build subagent prompt** using `<subagent_prompt>` template

5. **Dispatch 2 subagents in parallel**
   - Output before spawning: "Checking {N} files against project rules with 2 parallel agents..."
   - Use Task tool with 2 parallel invocations
   - Configuration: `subagent_type: general-purpose`, `model: sonnet`
   - Each gets identical prompt with all reference docs
   - Construct placeholders:
     - `$SCOPE_DESCRIPTION`: e.g., "staged changes" or "branch changes vs main"
     - `$LOADED_REFERENCE_DOCS`: concatenate contents of loaded reference files
     - `$DIFF_OR_FILE_CONTENT`: the diff output or file content from step 2

6. **Compile findings**
   - Merge results from both agents
   - Deduplicate by: file + line + rule source (CLAUDE.md section name)
   - When source matches, keep the more specific description
   - Note source document for each rule

7. **Generate report** (OUTPUT GATE)
   - Generate report using `<report_format>`
   - End output with `---` separator
   - **PROHIBITED after separator:**
     - "Let me...", "I'll...", "Now I will..."
     - "Starting with...", "First I'll..."
     - Any action-announcing language
   - Proceed directly to Confirm step

8. **Confirm action** (if violations found)
   - IMMEDIATELY use `AskUserQuestion` with options:
     - **Fix all** — apply all recommended fixes
     - **Fix selected** — choose which violations to fix
     - **Skip** — leave violations unfixed

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
For EACH rule in the reference documents:
1. State the exact rule text
2. Search the diff for violations of that specific rule
3. Record any violations found

Do not summarize or categorize rules. Check each rule literally and individually.
Treat every rule as equally important — do not skip rules that seem minor.
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

<success_criteria>

- [ ] Checked all files in scope
- [ ] Validated against all loaded reference documents
- [ ] Returned valid JSON matching schema
- [ ] Each violation cites specific rule and source
      </success_criteria>
      </subagent_prompt>

<report_format>

## Check: Project Rules Compliance

**Scope:** {scope_description}
**Files checked:** {file_count}
**Agents:** 2 parallel

### Violations

| #   | File       | Line | Rule                   | Source    |
| --- | ---------- | ---- | ---------------------- | --------- | ----------- | --------- |
| 1   | `file.ts`  | 42   | ⚠️ Use ?? for defaults | CLAUDE.md |
| 2   | `other.ts` | 15   | ⚠️ Avoid               |           | for nullish | CLAUDE.md |

**Details:**

1. `file.ts:42` — Uses `||` where `??` is appropriate for nullish coalescing
2. `other.ts:15` — Same pattern, should use nullish coalescing

**Summary:** {file_count} files, {violation_count} violations

**Recommendation:** Fix 1, 2 — straightforward replacements.

If no violations:

```
✓ All checks passed

Scope: {scope_description}
Files: {file_count} checked against {rule_count} rules
```

---

## ▶ Next Up

**Fix violations** — apply recommended changes

`/review staged` — review fixes before committing

---

**Also available:**

- `/commit` — commit after fixing
- `/lint staged` — re-check after fixes

---

</report_format>

<success_criteria>

- [ ] Scope determined correctly
- [ ] All changed files included (verified via --name-only)
- [ ] Reference documents loaded
- [ ] 2 subagents dispatched in parallel
- [ ] Violations deduplicated and compiled
- [ ] Report generated with rule sources
- [ ] User chose action for violations (if any)

</success_criteria>
