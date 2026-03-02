---
name: daily
model: haiku
description: Use each morning to start the day. Carries over incomplete tasks from previous days, adds Slack/Linear context as notes, and writes a curated reading list to today's day section.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Glob
  - mcp__slack__slack_search_public_and_private
  - mcp__slack__slack_read_thread
  - mcp__linear__list_issues
  - mcp__linear__get_issue
---

<skill_overview>
Morning routine that runs once per day. Carries over incomplete tasks from previous days, enriches active tasks with Slack/Linear context, and appends a curated reading list based on your interests profile. All output goes to today's day section in the current weekly file. HIGH RIGIDITY — follow steps in order.
</skill_overview>

<the_process>

## Step 1: Resolve the weekly file path

Run:

```bash
bun $SCRIPTS/claude/notebox.ts weekly-path
```

Example output: `/home/sqve/notebox/weekly/2026-W10.md`

## Step 2: Create weekly file if missing

If `$NOTEBOX/weekly/YYYY-WNN.md` does not exist, create it:

```markdown
# YYYY-WNN
```

(Single H1 with the week identifier, one blank line after. Nothing else.)

## Step 3: Create today's day section if missing

Get today's date:

```bash
bun $SCRIPTS/claude/notebox.ts today
```

Today's section header format: `## {DayName} YYYY-MM-DD`

If missing, insert it in chronological order among existing day sections — before `## Review` if it exists, otherwise at the end.

## Step 4: Find incomplete tasks from previous days

**Current weekly file:** Read the file. Collect all `- [ ]` and `- [-]` lines that appear in day sections *before* today's section. A day section boundary is any `## ` heading that is not today's.

**Previous weekly file:** Compute last week's path:

```bash
bun $SCRIPTS/claude/notebox.ts prev-weekly-path
```

If that file exists, collect all `- [ ]` and `- [-]` lines from its day sections.

**Deduplication:** For each collected task, strip the task text (everything after the task prefix `- [ ] ` or `- [-] ` and before any ` — carried from` label). Skip it if an identical or near-identical task (regardless of state) already exists in today's `### Tasks` section.

If no incomplete tasks are found, skip steps 5 and 6 and proceed to step 7.

## Step 5: Write carried-over tasks to today's section

For each incomplete task (oldest first), insert into today's `### Tasks` section using context group placement. Preserve the original task prefix (`- [ ]` or `- [-]`):

```
- [ ] Fix the login bug — carried from Mon 2026-03-01
- [-] Fix the auth issue — carried from Mon 2026-03-01
```

The origin label format is `— carried from {DayName} {YYYY-MM-DD}`.

Create `### Tasks` if it does not exist.

**Context group placement:** Extract the `(context-name)` suffix from the task text, before any ` — carried from` label. Use the same insertion algorithm as capture Step 8 — find or create the `` `{context}`: `` group sorted alphabetically, insert before the first `- [x]` in that group (or before the next group header, or at group end). Tasks with no context suffix go at the top of `### Tasks` without a header.

Do NOT rewrite the file. Use Edit to insert at the correct point.

## Step 6: Add Slack and Linear context as notes

For each carried-over task:

**Slack context:**
- Extract 2–3 keywords from the task text (nouns and main verbs — skip common words like "fix", "check", "update" unless they're the only option)
- Call `mcp__slack__slack_search_public_and_private` with those keywords
- If results exist from the last 7 days, pick the single most relevant thread
- Fetch its content with `mcp__slack__slack_read_thread` if needed
- Add to `### Notes`: `**{short task name} (Slack):** {one sentence summary of the thread}`
- Skip if no relevant results

**Linear context:**
- Call `mcp__linear__list_issues` with the task keywords as the query
- If matching open issues exist, pick the most relevant one
- Call `mcp__linear__get_issue` to get details
- Add to `### Notes`: `**{short task name} (Linear):** {ISSUE-ID} {title} — {status}`
- Skip if no relevant results

**Notebox context:**
- Run `qmd search "{task keywords}" -c notebox -n 3`
- Filter results to `reference/*.md` and `projects/*.md` only (skip weekly files)
- If results exist with score ≥ 60%, pick the single most relevant chunk
- Add to `### Notes`: `**{short task name} (Notebox):** {one sentence from the matched chunk}`
- Skip if no results meet the threshold

Create `### Notes` only if at least one context note was added.

## Step 7: Write curated reading list

Run:

```bash
bun $SCRIPTS/claude/fetch-feeds.ts $NOTEBOX/reference/feeds.md --hours 48 --per-category 10
```

This returns a JSON array of recent feed items: `[{title, url, feed, published, summary, category}]`, capped at 10 per category.

**If items are returned:** Read `$NOTEBOX/reference/interests.md` and `$NOTEBOX/reference/feeds.md`. Use them to rank items within each category:

- Prefer items that match topics in **Topics I care about**
- Skip or rank last items matching **Deprioritize**
- Within a category, prefer items from higher-priority feeds listed in **Feed priority**

Group items by `category`. Use the category name as a `**bold:**` label (bold text with trailing colon) followed by a blank line. For each category, pick the count from **Feed priority** in `feeds.md` (e.g. `Swedish news — 5` means pick 5). Categories not listed in **Feed priority** get 3 items by default. Write to today's `### Reading` section:

```markdown
### Reading

**Category name:**

- [Article Title](url) — one sentence on why it's relevant.
- [Article Title](url) — one sentence on why it's relevant.

**Another category:**

- [Article Title](url) — one sentence on why it's relevant.
```

The sentence must come from the item's summary, not invented.

**If the script returns an empty array or fails:** Write `### Reading\n\nNo articles found today.`

Create `### Reading` if missing. Its position within today's section: after `### References` (or after `### Notes`, or after `### Tasks`) — always last among subsections.

## Step 8: Compile PDF

Compile the weekly file to PDF:

```bash
cd "$NOTEBOX" && make weekly/YYYY-WNN
```

Where `YYYY-WNN` is the week identifier from Step 1. If the command fails, output:

```
Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
```

## Step 9: Confirm to user

Output:

```
Morning brief for YYYY-MM-DD
  Tasks carried over: N (or "none")
  Context notes added: N (or "none — Slack/Linear unavailable" if MCP failed)
  Reading list: N links
```

</the_process>

<error_handling>

**If `$NOTEBOX` is not set:** Stop immediately. Report: "`NOTEBOX` environment variable is not set. Set it in your Claude settings.json env block."

**If the weekly file exists but is malformed:** Do NOT attempt to repair it. Notify the user and stop.

**If `notebox.ts` fails:** Ask the user: "What is today's date?"

**If Slack MCP is unavailable:** Skip Slack context in step 6. Note "Slack unavailable" in the summary.

**If Linear MCP is unavailable:** Skip Linear context in step 6. Note "Linear unavailable" in the summary.

**If `fetch-feeds.py` fails or returns empty:** Write "No articles found today." in `### Reading`.

</error_handling>

<weekly_file_format>

Day section subsection order: **Tasks → Notes → References → Reading**

Example output after running /daily:

```markdown
## Monday 2026-03-02

### Tasks

`myrepo`:

- [ ] Fix auth bug (myrepo) — carried from Fri 2026-02-28
- [ ] Review PR #456 (myrepo) — carried from Mon 2026-03-02

### Notes

**Fix auth bug (Slack):** Thread in #eng-backend mentions the auth service restart may have introduced the regression.
**Fix auth bug (Linear):** ENG-789 "Auth token expiry regression" — In Review

### Reading

**Software development:**

- [Rust async patterns in 2026](url) — Covers tokio 2.0 changes and how they affect existing async codebases.

**Hardware and making:**

- [NixOS on Raspberry Pi 5](url) — Step-by-step flake setup for ARM builds with cross-compilation tips.
- [KiCad 8 differential pair routing](url) — Practical walkthrough of impedance-controlled routing for USB 3.2 boards.
```

</weekly_file_format>

<anti_patterns>

- ❌ Writing Slack/Linear context anywhere except `### Notes` within today's day section
- ❌ Carrying over tasks already present in today's Tasks (always deduplicate)
- ❌ Inventing article URLs or titles — use only actual feed items or WebSearch results; copy URLs verbatim from fetch-feeds output, never construct them from titles
- ❌ Placing `### Reading` before `### Notes` or `### Tasks` (maintain order)
- ❌ Using relative paths — always use the full `$NOTEBOX/weekly/` path
- ❌ Rewriting the whole file — use Edit to insert at the correct point only
- ❌ Appending carried-over tasks to the end of `### Tasks` without context group placement
- ❌ Using `**Category name**` without trailing colon for reading headers (must be `**Category name:**`)

</anti_patterns>

<success_criteria>

- [ ] `$NOTEBOX` resolved and path is valid
- [ ] Today's day section exists in the current weekly file
- [ ] Incomplete tasks from prior days appear in today's `### Tasks` with carry-over labels; `- [-]` tasks carry over with `- [-]` prefix preserved (not reset to `- [ ]`)
- [ ] No duplicate tasks (deduplication applied)
- [ ] Relevant Slack/Linear/Notebox context added to `### Notes` (or skipped if unavailable/below threshold)
- [ ] Carried-over tasks placed in correct `` `context`: `` group within `### Tasks` (alphabetical, general tasks at top without header)
- [ ] Reading list grouped by category with `**Category:**` bold headers, ~5 items per active category
- [ ] All links are from actual feed items or WebSearch results (no invented URLs)
- [ ] Summary printed to user

</success_criteria>

<integration>

**Reads:** tasks from previous day sections (written by capture/daily), previous weekly file (for cross-week carry-over)
**Produces:** carried-over tasks in today's `### Tasks`; Slack/Linear context in `### Notes`; reading list in `### Reading`
**Consumed by:** weekly (reviews week's tasks at end of week)

</integration>
