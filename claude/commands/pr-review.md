---
name: pr-review
description: Review someone else's PR with inline annotations and GitHub-ready output
argument-hint: '[pr-number]'
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
Review a PR for bugs, logic errors, security issues, and style problems. Add inline annotations to files and generate GitHub-ready markdown for posting comments.

Assumes user is in a worktree checked out to the PR branch. Annotations stay in files; user discards worktree when done.
</objective>

<arguments>
- **pr-number** (optional): PR number to review. Detects from current branch if omitted.
</arguments>

<process>
1. **Validate prerequisites**
   - Run `git rev-parse --git-dir` — if fails: "Not a git repository"
   - Detect PR: `gh pr view {pr-number} --json number,baseRefName,title -q '.'` (omit `{pr-number}` if not provided)
   - If no PR: "No PR found for this branch. Checkout the PR branch first."
   - Store base branch name for diff

2. **Get content**
   - Get merge base: `git merge-base HEAD origin/{base}`
   - List changed files: `git diff --name-only {merge_base}..HEAD`
   - If no files: "No changes found"
   - For each changed file:
     - Read full file content (not just diff)
     - Get diff hunks: `git diff {merge_base}..HEAD -- {file}`
   - Output: "Reviewing {N} files with 3 parallel agents..."

3. **Dispatch 3 subagents in parallel**
   - Each receives identical prompt with ALL changed files
   - Each file includes: full content + diff hunks
   - Use `superpowers:code-reviewer` agent type
   - Each reviews independently using `<subagent_prompt>` template

4. **Compile findings**
   - Merge results from all 3 agents
   - Deduplicate by: file + line range overlap
   - Note consensus: 3/3, 2/3, or 1/3 agents found issue
   - Higher consensus = higher confidence
   - Sort by: consensus desc, then severity, then file path

5. **Add inline annotations** (MANDATORY)
   - **DO THIS NOW** — do not skip to output
   - For each finding, use Edit tool to insert comment above the code line
   - Use block comment syntax appropriate for the file type
   - For multi-line findings, add `@review-end` marker after the range
   - Verify annotations exist: `grep -r "@review" .`

6. **Generate output** (OUTPUT GATE)
   - Only proceed here AFTER annotations are in files
   - Summary: file count, finding counts by severity
   - GitHub-ready markdown per finding using `<output_format>`
   - End with `---` separator
   - **PROHIBITED after separator:**
     - "Let me...", "I'll...", "Now I will..."
     - Any action-announcing language

7. **Confirm action**
   - Annotations are already in files at this point
   - IMMEDIATELY use `AskUserQuestion` with options:
     - **Done** — keep annotations, finish review
     - **Remove annotations** — strip all `@review` comments from files
     - **Cancel** — no further action

<anti_patterns>
After presenting findings, NEVER:
- "Let me create/start/begin..."
- "I'll now..."
- "Starting with the first..."
- Announcing intent before user chooses action
</anti_patterns>
</process>

<subagent_prompt>
<review_context>
<pr_title>$PR_TITLE</pr_title>
<base_branch>$BASE_BRANCH</base_branch>
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
- Logic errors and bugs
- Security vulnerabilities
- Edge cases and error handling
- Performance issues
- Code style and maintainability
</review_focus>

<context_awareness>
You have FULL FILE CONTENT, not just diffs. Before flagging an issue:
- Check if validation/handling exists elsewhere in the file
- Check if the suggested fix already exists (don't add what's there)
- Understand framework behavior (e.g., Next.js notFound() throws, React hooks rules)
- Look at imports to understand available utilities and patterns
- Consider parent/child component relationships visible in the file
</context_awareness>

<severity_guide>
- **critical**: Bugs that will cause failures, security vulnerabilities, data loss risks
- **suggestion**: Logic gaps, missing edge cases, performance improvements, better approaches
- **nitpick**: Style issues, naming, minor improvements
</severity_guide>

<subagent_output_format>
Return findings as JSON array:

```json
[
  {
    "severity": "critical|suggestion|nitpick",
    "file": "path/to/file.ts",
    "start_line": 42,
    "end_line": 45,
    "code_snippet": "the problematic code",
    "description": "Clear description of the issue",
    "suggestion": "How to fix it"
  }
]
```

For single-line findings, `start_line` and `end_line` are the same.
Return empty array `[]` if no issues found.
</subagent_output_format>

<success_criteria>
- [ ] Reviewed all files in scope
- [ ] Used full file context to verify issues exist
- [ ] Identified bugs, logic errors, and security issues
- [ ] Returned valid JSON matching schema
- [ ] Each finding has severity, description, and suggestion
</success_criteria>
</subagent_prompt>

<comment_syntax>
Use block comment syntax for the file type. Pattern:

```
@review(severity)
Description of the issue
Suggestion: How to fix it
```

For multi-line ranges, add `@review-end` after the last line of problematic code.
</comment_syntax>

<output_format>
```
✓ Review complete: {file_count} files, {total_findings} findings (3 agents)

| # | File | Line | Severity | Issue | Consensus |
|---|------|------|----------|-------|-----------|
| 1 | `auth.ts` | 42 | critical | SQL injection vulnerability | 3/3 |
| 2 | `api.ts` | 88 | suggestion | Missing error handling | 2/3 |
| 3 | `utils.ts` | 15 | nitpick | Consider renaming variable | 1/3 |

**Summary:** {critical} critical, {suggestion} suggestions, {nitpick} nitpicks
**Recommendation:** Prioritize 3/3 consensus findings. Review 2/3 manually. Consider skipping 1/3.

Annotations added to files. View with your editor or `grep -r "@review" .`
```

---

## GitHub comments (copy each individually)

### 1. {file}:{line} ({severity}) — {consensus}

```{lang}
{code_snippet}
```

{description}

**Suggestion:** {suggestion}

---

(Repeat for each finding)

Each numbered section is standalone for posting to GitHub's review UI at the specific file:line.

If no issues found:
```
✓ No issues found

PR: {pr_title}
Files reviewed: {file_count} (3 agents, full context)
```

---

## ▶ Next up

**Post comments to GitHub** — copy sections above to PR review

`gh pr view --web` — open PR in browser

---

**Also available:**

- `/review` — review your own changes
- `/pr-annotate` — add explanatory comments to your own PR

---
</output_format>

<success_criteria>
- [ ] PR detected from branch or argument
- [ ] Full file content retrieved for all changed files
- [ ] 3 parallel subagents dispatched with identical prompts
- [ ] Findings compiled with consensus tracking (3/3, 2/3, 1/3)
- [ ] Inline annotations added to files with correct syntax
- [ ] Multi-line findings have @review-end markers
- [ ] GitHub markdown output includes consensus per finding
- [ ] User confirmed final action
</success_criteria>
