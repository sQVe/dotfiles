---
name: capture
model: haiku
description: Use when logging daily work items, recording observations, or saving links — or when another skill needs to record a suggestion. Routes input to the correct weekly file section, infers type, creates missing sections, and polishes formatting automatically.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Glob
---

<skill_overview>
Accept rough input, infer its type, and append it to the correct section of this week's weekly file. Create the file and any missing sections automatically. AI-initiated content goes to ## AI suggestions, never to day sections. HIGH RIGIDITY — follow exact routing rules and file manipulation steps exactly.
</skill_overview>

<the_process>

## Step 1: Resolve the weekly file path

Run this to get the path:

```bash
bun $SCRIPTS/claude/notebox.ts weekly-path
```

Example output: `/home/sqve/notebox/weekly/2026-W09.md`

## Step 2: Detect input type

Classify the input as one of: **completion**, **task**, **note**, **reference**

| Type       | Detection rule                                                                                                                                                                     |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| completion | Describes the outcome of an existing task ("done", "complete", "decided", "evaluated", "not necessary", "no longer needed", or starts with `- [x]`)                               |
| reference  | Contains a URL, or user says "reference" or "link"                                                                                                                                 |
| task       | Contains action verb ("fix", "add", "build", "check", "write", "update", "review", "create", "investigate", "test") OR starts with `- [ ]` OR is a question about something to do |
| note       | Everything else — observations, learnings, thoughts                                                                                                                                |

When ambiguous, prefer: completion > reference > task > note

## Step 3: Check initiator

**User-initiated** (default): route to today's day section.
**AI-initiated** (skill called by another skill, or prefixed with `[AI]`): route to `## AI suggestions` section only.

## Step 4: Create weekly file if missing

If `$NOTEBOX/weekly/YYYY-WNN.md` does not exist, create it:

```markdown
# YYYY-WNN
```

(Single H1 with the week identifier, one blank line after. Nothing else.)

## Step 5: Find or create today's day section

Today's section header format: `## {DayName} YYYY-MM-DD`

Example: `## Monday 2026-03-02`

Get today's day name and date:

```bash
bun $SCRIPTS/claude/notebox.ts today
```

**Finding the section:** Read the file, look for `## {DayName} {Date}`.

**If missing:** Insert it in chronological order among existing day sections. If no later day section exists, insert before `## AI suggestions` or `## Review` (if they exist). Otherwise append at the end.

```markdown
## Monday 2026-03-02
```

## Step 6: Handle completion type (early exit)

If type is **completion**, do this instead of steps 6–9:

1. Extract the task text from the input — strip any `- [x]`, outcome phrases ("done", "not necessary", etc.), and leading punctuation. The remainder is the task description to match.

2. Search the entire weekly file for `- [ ] {task text}` (fuzzy match — ignore repo suffix, carry-over labels, minor wording differences). Check all day sections, newest first.

3. If the input includes a conclusion (e.g., "not necessary — no dotfiles commands warrant conversion"), extract and polish it: fix spelling/punctuation, remove filler. Otherwise conclusion is empty.

4. If found: replace that line with `- [x] {original task text}` (appending ` — *{conclusion}*` if a conclusion exists) using Edit (exact line match). Do NOT rewrite the file.
   - Example with conclusion: `- [x] Check if dotfiles commands should be converted (dotfiles) — *none warrant conversion*`
   - Example without: `- [x] Fix the login bug (myrepo)`

4a. **Move completed task to end of its group:**
   - Extract context from the task line: the `(context-name)` suffix at the end, before any ` — carried from` label.
   - For tasks with context: find the `` `{context}`: `` header. Group end is the next `` `...`: `` line OR the `### Tasks` section end.
   - For tasks without context: group end is the first `` `...`: `` line in `### Tasks` OR the section end.
   - If no context group headers exist at all, skip the move.
   - If the task line is already immediately before the group end, skip (no-op).
   - Otherwise: use two Edit operations — first delete the `- [x]` line from its current position, then insert it immediately before the group end.

5. Compile the weekly file to PDF:

   ```bash
   cd "$NOTEBOX" && make weekly/YYYY-WNN
   ```

   Where `YYYY-WNN` is the week identifier from Step 1. If the command fails, output:

   ```
   Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
   ```

6. Output confirmation and stop:
   ```
   Captured completion to $NOTEBOX/weekly/YYYY-WNN.md → marked ✓ {task text}
   ```
   If task not found in file, warn: "No matching open task found for: {task text}. Captured as note instead." Then fall through to note routing.

## Step 6b: Find or create the subsection

Within today's day section, subsections appear in this order: Tasks, Notes, References.

**Target subsection by type:**

- task → `### Tasks`
- note → `### Notes`
- reference → `### References`

**If subsection missing:** Insert it in the correct position within today's day section. Maintain the ordering: Tasks before Notes before References. Do not add empty subsections — only add the subsection you need.

## Step 7: Polish the input

**Tasks:** Strip filler, make imperative. Then detect git repo context:

```bash
basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null
```

If non-empty, append `(repo-name)` to the task. If not in a git repo, omit.

- "I need to fix the login bug" → `- [ ] Fix the login bug (myrepo)`
- "check if the deployment worked" → `- [ ] Check if deployment worked (myrepo)`

**Notes:** Fix spelling and punctuation. Remove filler phrases ("I think", "maybe", "probably"). Do not change the substance.

- "Maybe this is related to the cache issue" → `Likely related to the cache issue.`

**References:**

- Fetch the URL to get the actual page title. If the fetch fails, use the raw URL as the title and omit the summary.
- Write a one-sentence summary of why it's useful
- Format: `- [Title](url) — one-sentence summary.`

## Step 8: Insert the content

**For notes and references:** Append at the end of the target subsection (before the next `###` or `##` heading, or end of file if none follows). Do NOT rewrite the whole file.

**For tasks:** Insert into the correct context group within `### Tasks`.

**Context extraction:** From the polished task line, extract the `(context-name)` suffix — the parenthetical at the end, before any ` — carried from` label. Strip surrounding parens.

**Context group header pattern:** A line matching `` `name`: `` (backtick-wrapped name followed by a colon, alone on its line). Named groups are sorted alphabetically within `### Tasks`. Tasks with no context go at the top, before all named groups, with no header.

**Insertion algorithm:**
1. Locate the `### Tasks` section (from `### Tasks` heading to the next `###` or `##` heading, or end of file).
2. **No context:** Find the first `` `...`: `` header OR the first `- [x]` ungrouped line — insert immediately before that point. If neither exists, append at end of section.
3. **Named context:** Scan for `` `{context}`: `` line within the section.
4. If found: scan forward from that header to find the first `- [x]` line OR the next `` `...`: `` header OR the section end — whichever comes first. Insert immediately before that point.
5. If NOT found: determine alphabetical insertion position among existing `` `...`: `` headers. Insert a new group block at that position: blank line, `` `{context}`: ``, blank line, then the task line.

## Step 9: AI suggestions path

If AI-initiated, skip steps 5–6. Steps 7–8 still apply.

Find or create `## AI suggestions` section at the bottom of the file (before `## Review` if it exists, otherwise at the end). Append content with a type label:

- task → `- [ ] (suggested) Fix the login bug`
- note → `Note: Likely related to the cache issue.`
- reference → `Suggested reading: [Title](url) — summary.`

## Step 10: Compile PDF

Compile the weekly file to PDF:

```bash
cd "$NOTEBOX" && make weekly/YYYY-WNN
```

Where `YYYY-WNN` is the week identifier from Step 1. If the command fails, output:

```
Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
```

## Step 11: Confirm to user

After writing, output a one-line confirmation:

```
Captured [type] to $NOTEBOX/weekly/YYYY-WNN.md → ## Day / ### Section
```

Example:

```
Captured task to /home/sqve/notebox/weekly/2026-W09.md → ## Monday 2026-03-02 / ### Tasks
```

</the_process>

<scope>

This skill:
- Captures to the current week only — no retroactive insertion into past weeks
- Expects one item per invocation — does not split multi-item input
- Does not deduplicate — capturing the same task twice creates two entries
- Does not track task completion — that belongs in the `## Review` section
- Requires weekly files to follow the exact format specified in `<weekly_file_format>`
- Requires `$NOTEBOX` environment variable to be set

</scope>

<error_handling>

**If `$NOTEBOX` is not set:**
- Stop immediately
- Report: "`NOTEBOX` environment variable is not set. Set it in your Claude settings.json env block."

**If the weekly file exists but is malformed** (wrong heading level, missing H1, corrupted structure):
- Do NOT attempt to repair the file
- Notify the user: "$NOTEBOX/weekly/YYYY-WNN.md exists but appears malformed. Fix it manually or I can create a fresh one."
- Stop

**If the day section ordering is ambiguous** (two sections with the same date):
- Use the first occurrence
- Notify the user of the duplicate

**If `notebox.ts` fails**:
- Do NOT guess the date
- Ask the user: "What is today's date?"

**If URL fetch times out** (>10 seconds) or returns a non-2xx response:
- Use the raw URL as the title
- Omit the summary
- Format: `- [url](url)`

**If URL fetch succeeds but page has no title**:
- Use the domain name as the title: `- [example.com](https://example.com) — summary.`

</error_handling>

<weekly_file_format>

```markdown
# 2026-W09

## Monday 2026-03-02

### Tasks

- [ ] Task three

`notebox`:

- [ ] Task one (notebox)
- [x] Task two (notebox)

### Notes

Observation or learning.

### References

- [Title](url) — one-sentence summary of why it's useful.

## Tuesday 2026-03-03

### Notes

Another observation.

## AI suggestions

Suggested reading: [Title](url) — why it might be relevant.

## Review

### Completed

Brief summary of what got done.

### Rolled over

- [ ] Task that didn't happen.

### To promote

Notes or references worth extracting to reference/\*.md.
```

Rules:

- Skip days and subsections with no content — no empty headings
- `## AI suggestions` is always after all day sections
- `## Review` is always last
- Notes are rough — polish belongs in reference files

</weekly_file_format>

<anti_patterns>

- ❌ Writing AI-generated content into day sections (put it in ## AI suggestions)
- ❌ Creating empty subsections (only create subsections when adding content)
- ❌ Rewriting the entire file (use Edit to append at insertion point)
- ❌ Skipping URL fetching (always get real title and write summary)
- ❌ Assuming task type from context when it could be a note (classify carefully)
- ❌ Using relative paths like `weekly/` — always use the full `$NOTEBOX/weekly/` path
- ❌ Appending tasks to the end of `### Tasks` without placing them in their context group

</anti_patterns>

<rationalizations>

These mean: use /capture anyway.

- "This is just a quick note" → still needs type detection and routing
- "I'll edit the file directly" → direct edits skip insertion order, polish, and AI/user routing
- "The format doesn't matter here" → it does; subsection order and prefix rules are exact
- "I already know which section to write to" → still run the skill; it enforces rules you might miss

</rationalizations>

<success_criteria>

The skill ran correctly when ALL of these are true:

- [ ] `$NOTEBOX` was resolved and the path is valid
- [ ] Weekly file exists at the correct `$NOTEBOX/weekly/YYYY-WNN.md` path
- [ ] The file starts with `# YYYY-WNN` (H1 only, nothing else before it)
- [ ] Today's `## DayName YYYY-MM-DD` section exists
- [ ] Tasks inserted into correct context group within `### Tasks` — general tasks at top (no header), named groups as `` `context`: `` sorted alphabetically below (incomplete before completed within group); notes to `### Notes`; references to `### References`
- [ ] Tasks use `- [ ]` prefix, imperative verb, and `(repo-name)` suffix when in a git repo
- [ ] References include a fetched title (or raw URL as fallback) and em-dash summary
- [ ] No empty subsections were created
- [ ] AI-initiated content appears only in `## AI suggestions`, never in a day section
- [ ] Completions: matching `- [ ]` task found and changed to `- [x]`; conclusion appended as ` — *{conclusion}*` on the task line if present
- [ ] The confirmation line was output to the user

</success_criteria>

<integration>

**Produces:** tasks/notes/references in day sections; AI-initiated content in `## AI suggestions`
**Consumed by:** daily (carries over tasks), weekly (reviews completed/incomplete tasks), triage (processes AI suggestions)
**Called after:** completing any task that originated from a notebox weekly file — use completion type to mark `- [ ]` → `- [x]`

</integration>
