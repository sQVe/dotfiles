---
name: daily
description: Morning routine skill. Carries over incomplete tasks from previous days, adds Slack/Linear context as notes, and writes a curated reading list to today's day section. Run once each morning.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Glob
  - WebSearch
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
python3 -c "
import os
from datetime import date
d = date.today()
iso = d.isocalendar()
notebox = os.environ.get('NOTEBOX', '')
if not notebox:
    raise SystemExit('NOTEBOX environment variable is not set')
print(f'{notebox}/weekly/{iso[0]}-W{iso[1]:02d}.md')
"
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
python3 -c "
from datetime import date
d = date.today()
print(d.strftime('%A %Y-%m-%d'))
"
```

Today's section header format: `## {DayName} YYYY-MM-DD`

If missing, insert it in chronological order among existing day sections — before `## AI suggestions` or `## Review` if they exist, otherwise at the end.

## Step 4: Find incomplete tasks from previous days

**Current weekly file:** Read the file. Collect all `- [ ]` lines that appear in day sections *before* today's section. A day section boundary is any `## ` heading that is not today's.

**Previous weekly file:** Compute last week's path:

```bash
python3 -c "
import os
from datetime import date, timedelta
last_week = date.today() - timedelta(weeks=1)
iso = last_week.isocalendar()
notebox = os.environ.get('NOTEBOX', '')
print(f'{notebox}/weekly/{iso[0]}-W{iso[1]:02d}.md')
"
```

If that file exists, collect all `- [ ]` lines from its day sections.

**Deduplication:** For each collected task, strip the task text (everything after `- [ ] ` and before any ` — carried from` label). Skip it if an identical or near-identical task already exists in today's `### Tasks` section.

If no incomplete tasks are found, skip steps 5 and 6 and proceed to step 7.

## Step 5: Write carried-over tasks to today's section

For each incomplete task (oldest first), append to today's `### Tasks` section:

```
- [ ] Fix the login bug — carried from Mon 2026-03-01
```

The origin label format is `— carried from {DayName} {YYYY-MM-DD}`.

Create `### Tasks` if it does not exist. If today already has tasks, append after the last existing one.

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

Create `### Notes` only if at least one context note was added.

## Step 7: Write curated reading list

Read `$NOTEBOX/reference/interests.md`.

Pick 2–3 topics, varying across the file's sections. Prefer topics not recently covered (check today's existing `### Reading` if it already has entries).

For each topic, use `WebSearch` to find 1–2 recent articles (last 2 weeks when possible). Criteria: novel insight, practical value, or recent development — not basic tutorials or landing pages.

Select 3–5 total links. Write to today's `### Reading` section:

```markdown
### Reading

- [Article Title](url) — one sentence on why it's useful.
- [Article Title](url) — one sentence on why it's useful.
```

Create `### Reading` if missing. Its position within today's section: after `### References` (or after `### Notes`, or after `### Tasks`) — always last among subsections.

If WebSearch returns no usable results, write: `### Reading\n\nNo articles found today.`

## Step 8: Confirm to user

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

**If python3 fails:** Ask the user: "What is today's date?"

**If Slack MCP is unavailable:** Skip Slack context in step 6. Note "Slack unavailable" in the summary.

**If Linear MCP is unavailable:** Skip Linear context in step 6. Note "Linear unavailable" in the summary.

**If WebSearch fails entirely:** Skip reading list. Note "WebSearch unavailable" in the summary.

</error_handling>

<weekly_file_format>

Day section subsection order: **Tasks → Notes → References → Reading**

Example output after running /daily:

```markdown
## Monday 2026-03-02

### Tasks

- [ ] Fix auth bug — carried from Fri 2026-02-28
- [ ] Review PR #456 — carried from Mon 2026-03-02

### Notes

**Fix auth bug (Slack):** Thread in #eng-backend mentions the auth service restart may have introduced the regression.
**Fix auth bug (Linear):** ENG-789 "Auth token expiry regression" — In Review

### Reading

- [Rust async patterns in 2026](url) — Covers tokio 2.0 changes and how they affect existing async codebases.
- [NixOS on Raspberry Pi 5](url) — Step-by-step flake setup for ARM builds with cross-compilation tips.
- [KiCad 8 differential pair routing](url) — Practical walkthrough of impedance-controlled routing for USB 3.2 boards.
```

</weekly_file_format>

<anti_patterns>

- ❌ Writing Slack/Linear context anywhere except `### Notes` within today's day section
- ❌ Carrying over tasks already present in today's Tasks (always deduplicate)
- ❌ Inventing article URLs or titles — use only actual WebSearch results
- ❌ Placing `### Reading` before `### Notes` or `### Tasks` (maintain order)
- ❌ Using relative paths — always use the full `$NOTEBOX/weekly/` path
- ❌ Rewriting the whole file — use Edit to insert at the correct point only

</anti_patterns>

<success_criteria>

- [ ] `$NOTEBOX` resolved and path is valid
- [ ] Today's day section exists in the current weekly file
- [ ] Incomplete tasks from prior days appear in today's `### Tasks` with carry-over labels
- [ ] No duplicate tasks (deduplication applied)
- [ ] Relevant Slack/Linear context added to `### Notes` (or skipped with note if MCP unavailable)
- [ ] Reading list with 3–5 links in today's `### Reading`
- [ ] All links are from actual WebSearch results
- [ ] Summary printed to user

</success_criteria>
