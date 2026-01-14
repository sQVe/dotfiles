---
name: annotate
description: Add self-review comments to PR changes via GitHub review
argument-hint: '[pr-number]'
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

<objective>
Identify non-obvious code in PR changes and post explanatory comments as a GitHub review.

The walkthrough presents each candidate interactively, then batches accepted comments into a single review.
</objective>

<arguments>
- **pr-number** (optional): PR number to annotate. Detects from current branch if omitted.
</arguments>

<process>
1. **Resolve PR**
   - If argument provided, use it directly
   - Otherwise: `gh pr view --json number -q '.number'`
   - If no PR found, refuse: "No PR found for this branch. Run `/pr` first."

2.  **Fetch PR metadata**
    - Get diff: `gh pr diff {pr_number}`
    - Get head commit: `gh pr view {pr_number} --json commits -q '.commits[-1].oid'`
    - Get repo: `gh repo view --json owner,name -q '"\(.owner.login)/\(.name)"'`

3.  **Phase 1: Find candidates** (subagent)
    - Launch one code-review subagent with the diff
    - Agent flags generously — anything matching `<detection_criteria>`
    - Returns list: file path, line range, code snippet, draft explanation
    - Err toward inclusion—filtering happens next

4.  **Phase 2: Filter candidates** (subagent)
    - Launch one filtering subagent with Phase 1 output
    - Agent scores each candidate 1-5 per `<scoring_criteria>`
    - Only candidates scoring 4+ proceed to walkthrough
    - Discarded candidates logged with reasoning (visible if user asks)

5.  **Interactive walkthrough**
    - For each filtered candidate:
      - Display per `<walkthrough_format>`
      - Show draft explanation (or "[needs manual write]" if undraftable)
      - Present options: **Accept** / **Edit** / **Skip**
      - If Accept: add to collection as-is
      - If Edit: prompt for revised text, then add
      - If Skip: discard
    - Continue until all candidates processed

6.  **Confirm submission**
    - Show summary: N comments across M files
    - List each: `file:line — first 50 chars...`
    - Ask with options:
      - **Submit**: post with `event=COMMENT`
      - **Keep pending**: post with `event=PENDING`
      - **Cancel**: discard all

7.  **Post review**
    - Build comments JSON per `<comment_format>`
    - Submit via `gh api` per `<api_call>`
    - Report success with review URL

</process>
<detection_criteria>
Flag code a typical reviewer might question:

**Non-obvious decisions**

- Alternative approaches exist
- Trade-offs made (performance vs readability, etc.)
- Intentional deviations from conventions

**Complex logic**

- Dense algorithms or transformations
- Nested conditionals (3+ levels)
- Regex patterns
- Bitwise operations
- Recursion

**Contextual changes**

- Modifications tied to external systems
- Changes requiring broader architecture knowledge
- Side effects not obvious from the code

**Balance**

- Skip self-explanatory code
- Skip standard patterns (null checks, error handling boilerplate)
- Prefer fewer, higher-value annotations

</detection_criteria>

<scoring_criteria>
Rate each candidate 1-5. Only 4+ proceed to walkthrough.

**5 — Essential**
Reviewer would definitely ask "why?" without explanation. Non-obvious architectural decision, surprising trade-off, or counterintuitive approach.

**4 — Valuable**
Reviewer would likely pause and wonder. Complex logic benefits from context, or decision isn't self-evident from the code.

**3 — Nice-to-have**
Might help some reviewers. Code is understandable but explanation adds minor clarity.

**2 — Low value**
Most reviewers wouldn't need this. Explanation states what code already shows.

**1 — Noise**
Self-explanatory code. Standard patterns. Would clutter the review.

**Filtering guidance**

- When in doubt, score lower — noise harms more than gaps
- Consider: "Would I personally wonder about this as a reviewer?"
- One high-value comment beats five mediocre ones
</scoring_criteria>

<tone>
Use the `elements-of-style:writing-clearly-and-concisely` skill.

Write as you would in a 30-second code review.

**Do:**
- "Uses bitwise AND here because status packs multiple flags"
- "Watch out: this modifies shared state"

**Don't:**
- Stiff: "One must consider the implications of this approach"
- Casual: "Yo heads up — bit trick incoming!"
- Padding: "It's worth noting that this section..."

One reason per sentence. Skip filler phrases.
</tone>

<comment_format>
Single line:

```json
{
  "path": "src/utils/parser.ts",
  "line": 42,
  "side": "RIGHT",
  "body": "Explanation..."
}
```

Multi-line range:

```json
{
  "path": "src/utils/parser.ts",
  "start_line": 38,
  "line": 42,
  "start_side": "RIGHT",
  "side": "RIGHT",
  "body": "Explanation..."
}
```

</comment_format>

<api_call>

```bash
# Build review payload with comments array wrapped in object
jq -n --argjson comments "$COMMENTS_JSON" '{comments: $comments}' > /tmp/review-payload.json

# Post batched review
gh api -X POST "/repos/{owner}/{repo}/pulls/{pr_number}/reviews" \
  -f commit_id="$COMMIT_SHA" \
  -f event="$EVENT" \
  -f body="" \
  --input /tmp/review-payload.json

rm /tmp/review-payload.json
```

- `$COMMENTS_JSON`: Array of comment objects per `<comment_format>`
- `$EVENT`: `COMMENT` to submit, `PENDING` to keep pending
</api_call>

<walkthrough_format>

```
── src/utils/parser.ts:38-42 ──────────────────────────
│ const result = items
│   .filter(x => x.status & FLAGS.ACTIVE)
│   .reduce((acc, x) => acc | x.permissions, 0);
───────────────────────────────────────────────────────

Draft: Uses bitwise AND to check ACTIVE flag and OR to
accumulate permissions. Avoids multiple iterations.

[A]ccept  [E]dit  [S]kip
```

If undraftable:

```
Draft: [needs manual write]

[E]dit  [S]kip
```

</walkthrough_format>

<success_criteria>

- [ ] PR resolved (from argument or current branch)
- [ ] Phase 1: Candidates found by subagent
- [ ] Phase 2: Candidates filtered (only 4+ scores)
- [ ] Each filtered candidate walked through interactively
- [ ] User confirmed submission action
- [ ] Review posted via GitHub API

</success_criteria>
