---
name: capture
model: haiku
description: Use when logging daily work items, recording observations, or saving links — or when another skill needs to record a suggestion. Routes input to the correct weekly file section, infers type, creates missing sections, and polishes formatting automatically.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Glob
  - WebFetch
---

<skill_overview>
Accept rough input, infer its type, and append it to the correct section of this week's weekly file. Create the file and any missing sections automatically. HIGH RIGIDITY — follow exact routing rules and file manipulation steps exactly.
</skill_overview>

<the_process>

## Step 1: Resolve the weekly file path

Run this to get the path:

```bash
bun $SCRIPTS/claude/notebox.ts weekly-path
```

Example output: `/home/sqve/notebox/weekly/2026-W09.md`

## Step 2: Detect input type

Classify the input as one of: **completion**, **started**, **cancelled**, **reference**, **project**, **task**, **note**

| Type       | Detection rule                                                                                                                                                                     |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| completion | Describes the outcome of an existing task ("done", "complete", "decided", "evaluated", "not necessary", "no longer needed", or starts with `- [x]`)                               |
| started    | Describes beginning work on an existing task ("started", "working on", "in progress", "began", "kicking off") OR starts with `- [-]`                                              |
| cancelled  | Describes dropping/abandoning a task ("cancel", "cancelled", "drop", "dropped", "scrapping", "won't do", "not doing", "skip") OR starts with `- [/]`                              |
| reference  | Contains a URL, or user says "reference" or "link"                                                                                                                                 |
| project    | User says "project update", "project log", names a known project, or starts with "for [project name]:"                                                                             |
| task       | Contains action verb ("fix", "add", "build", "check", "write", "update", "review", "create", "investigate", "test") OR starts with `- [ ]` OR is a question about something to do |
| note       | Everything else — observations, learnings, thoughts                                                                                                                                |

When ambiguous, prefer: completion > started > cancelled > reference > project > task > note

**Routing:** If type is completion → go to Step 5. If started → Step 5a. If cancelled → Step 5b. If project → Step 5c. Otherwise continue to Step 3.

## Step 3: Create weekly file if missing

If `$NOTEBOX/weekly/YYYY-WNN.md` does not exist, create it:

```markdown
# YYYY-WNN
```

(Single H1 with the week identifier, one blank line after. Nothing else.)

## Step 4: Find or create today's day section

Today's section header format: `## {DayName} YYYY-MM-DD`

Example: `## Monday 2026-03-02`

Get today's day name and date:

```bash
bun $SCRIPTS/claude/notebox.ts today
```

**Finding the section:** Read the file, look for `## {DayName} {Date}`.

**If missing:** Insert it in chronological order among existing day sections. If no later day section exists, insert before `## Review` (if it exists). Otherwise append at the end.

```markdown
## Monday 2026-03-02
```

## Step 5: Handle completion type (early exit)

If type is **completion**, do this instead of the normal flow (skip remaining steps):

1. Extract the task text from the input — strip any `- [x]`, outcome phrases ("done", "not necessary", etc.), and leading punctuation. The remainder is the task description to match.

2. Use qmd to find candidate files containing the task text:

   ```bash
   qmd search "{task text}" -c notebox -n 5
   ```

   From the results, extract file paths (format: `qmd://notebox/{path}:line`). Filter to `weekly/*.md` files only, most recent first. Also include the current weekly file if not in results. For each candidate file (newest first), read it and scan for `- [ ] {task text}` or `- [-] {task text}` (fuzzy match — ignore repo suffix, carry-over labels, minor wording differences) across all day sections, newest day first. Use the first match found.

3. If the input includes a conclusion (e.g., "not necessary — no dotfiles commands warrant conversion"), extract and polish it: fix spelling/punctuation, remove filler. Otherwise conclusion is empty.

4. If found: replace that line with `- [x] {original task text}` (appending ` — _{conclusion}_` if a conclusion exists) using Edit (exact line match). Do NOT rewrite the file.
   - Example with conclusion: `- [x] Check if dotfiles commands should be converted — _none warrant conversion_`
   - Example without: `- [x] Fix the login bug`

5. **Move completed task to end of its group:**
   - Extract context from the original task text: check the `(context-name)` suffix at the end (legacy format), or identify the context group header the task sits under.
   - For tasks with context: find the `` `{context}`: `` header. Group end is the next `` `...`: `` line OR the `### Tasks` section end.
   - For tasks without context: group end is the first `` `...`: `` line in `### Tasks` OR the section end.
   - If no context group headers exist at all, skip the move.
   - If the task line is already immediately before the group end, skip (no-op).
   - Otherwise: use two Edit operations — first delete the `- [x]` line from its current position, then insert it immediately before the group end.

6. Compile the weekly file to PDF:

   ```bash
   cd "$NOTEBOX" && make weekly/YYYY-WNN
   ```

   Where `YYYY-WNN` is the week identifier from Step 1. If the command fails, output:

   ```
   Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
   ```

7. Output confirmation and stop:
   ```
   Captured completion to $NOTEBOX/weekly/YYYY-WNN.md → marked ✓ {task text}
   ```
   If task not found in file, warn: "No matching open task found for: {task text}. Captured as note instead." Then fall through to note routing.

## Step 5a: Handle started type (early exit)

If type is **started**, do this instead of the normal flow (skip remaining steps):

1. Extract the task text — strip any `- [-]`, "started"/"working on" phrases, and leading punctuation. The remainder is the task description to match.

2. Use qmd to find candidate files containing the task text:

   ```bash
   qmd search "{task text}" -c notebox -n 5
   ```

   From the results, extract `weekly/*.md` file paths (most recent first). Also include the current weekly file if not in results. For each candidate file (newest first), read it and scan for `- [ ] {task text}` (fuzzy match — ignore repo suffix, carry-over labels, minor wording differences) across all day sections, newest day first. Use the first match found.

3. If found: replace `- [ ]` with `- [-]` using Edit (exact line match). Do NOT rewrite the file.
   - Example: `- [-] Fix the login bug (myrepo)`

4. Compile PDF:
   ```bash
   cd "$NOTEBOX" && make weekly/YYYY-WNN
   ```
   If the command fails, output:
   ```
   Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
   ```

5. Output confirmation and stop:
   ```
   Captured started to $NOTEBOX/weekly/YYYY-WNN.md → marked [-] {task text}
   ```
   If task not found in file, warn: "No matching open task found for: {task text}. Captured as note instead." Then fall through to note routing.

## Step 5b: Handle cancelled type (early exit)

If type is **cancelled**, do this instead of the normal flow (skip remaining steps):

1. Extract the task text — strip any `- [/]`, cancel phrases ("cancel", "drop", "won't do", etc.), and leading punctuation. The remainder is the task description to match.

2. Use qmd to find candidate files containing the task text:

   ```bash
   qmd search "{task text}" -c notebox -n 5
   ```

   From the results, extract `weekly/*.md` file paths (most recent first). Also include the current weekly file if not in results. For each candidate file (newest first), read it and scan for `- [ ] {task text}` or `- [-] {task text}` (fuzzy match — ignore repo suffix, carry-over labels, minor wording differences) across all day sections, newest day first. Use the first match found.

3. If found: replace `- [ ]` or `- [-]` with `- [/]` using Edit (exact line match). Do NOT rewrite the file.
   - Example: `- [/] Fix the login bug (myrepo)`

4. Compile PDF:
   ```bash
   cd "$NOTEBOX" && make weekly/YYYY-WNN
   ```
   If the command fails, output:
   ```
   Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
   ```

5. Output confirmation and stop:
   ```
   Captured cancellation to $NOTEBOX/weekly/YYYY-WNN.md → marked [/] {task text}
   ```
   If task not found in file, warn: "No matching open task found for: {task text}. Captured as note instead." Then fall through to note routing.

## Step 5c: Handle project type (early exit)

If type is **project**, do this instead of the normal flow (skip remaining steps):

1. Resolve the project file path:

   ```bash
   bun $SCRIPTS/claude/notebox.ts project-path
   ```

   Example output: `/home/sqve/notebox/projects/2026.md`

2. Read the file. Extract all H1 headings (`# Project name`) — these are existing projects.

3. **Identify target project:**
   - If user named a project (e.g., "for notebox automation:", "notebox project"), fuzzy-match to an H1. If no match, list existing projects and ask which one.
   - If no project named, list existing projects and ask.
   - If user wants to create a new project, ask for: name, category, one-sentence description. Append to the file:
     ```markdown
     # {Name}

     _{Category} · {YYYY-MM-DD} · Active_

     {Description}
     ```

4. Within the target project's section, check if today's date heading (`## {YYYY-MM-DD}`) already exists. Get today's date from `bun $SCRIPTS/claude/notebox.ts today` and extract just the date part.

5. Polish the input: fix spelling and punctuation. Remove filler phrases. Keep substance.

6. Insert the polished content:
   - If today's date heading exists: append after the last line of content under it (before the next `## ` heading or end of file).
   - If today's date heading is missing: append at the end of the project's section (before the next `# ` heading or end of file):
     ```markdown

     ## {YYYY-MM-DD}

     {content}
     ```

7. Compile the project file to PDF:

   ```bash
   cd "$NOTEBOX" && make projects/YYYY
   ```

   Where `YYYY` is the current year. If the command fails, output:

   ```
   Warning: PDF compilation failed for projects/YYYY — check typst install
   ```

8. Output confirmation and stop:
   ```
   Captured project update to $NOTEBOX/projects/YYYY.md → # Project Name / ## YYYY-MM-DD
   ```

## Step 6: Find or create the subsection

Within today's day section, subsections appear in this order: Tasks, Notes, References, Reading.

**Target subsection by type:**

- task → `### Tasks`
- note → `### Notes`
- reference → `### References`

**If subsection missing:** Insert it in the correct position within today's day section. Maintain the ordering: Tasks before Notes before References before Reading. Do not add empty subsections — only add the subsection you need. If a `### Reading` section exists (created by the daily skill), insert before it.

## Step 7: Polish the input

**Tasks:** Strip filler, make imperative. Then detect git repo context:

```bash
basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null
```

If non-empty, this is the **task context** — use it in Step 8 for group placement. Do NOT append it as a suffix to the task text; the context group header provides that information.

- "I need to fix the login bug" → `- [ ] Fix the login bug` (context: `myrepo`)
- "check if the deployment worked" → `- [ ] Check if deployment worked` (context: `myrepo`)

**Notes:** Fix spelling and punctuation. Remove filler phrases ("I think", "maybe", "probably"). Do not change the substance.

- "Maybe this is related to the cache issue" → `Likely related to the cache issue.`

**References:**

- Fetch the URL to get the actual page title. If the fetch fails, use the raw URL as the title and omit the summary.
- Write a one-sentence summary of why it's useful
- Format: `- [Title](url) — one-sentence summary.`

## Step 8: Insert the content

**For notes and references:** Append at the end of the target subsection (before the next `###` or `##` heading, or end of file if none follows). Do NOT rewrite the whole file.

**For tasks:** Insert into the correct context group within `### Tasks`.

**Context source:** Use the task context detected in Step 7 (the git repo name). If Step 7 found no context (not in a git repo), the task is ungrouped.

**Context group header pattern:** A line matching `` `name`: `` (backtick-wrapped name followed by a colon, alone on its line). Named groups are sorted alphabetically within `### Tasks`. Tasks with no context go at the top, before all named groups, with no header.

**Insertion algorithm:**
1. Locate the `### Tasks` section (from `### Tasks` heading to the next `###` or `##` heading, or end of file).
2. **No context:** Find the first `` `...`: `` header OR the first `- [x]` or `- [/]` ungrouped line — insert immediately before that point. Treat `- [-]` lines as incomplete (not as a stop point). If neither exists, append at end of section.
3. **Named context:** Scan for `` `{context}`: `` line within the section.
4. If found: scan forward from that header to find the first `- [x]` or `- [/]` line (treat `- [-]` as incomplete, not as a stop point) OR the next `` `...`: `` header OR the section end — whichever comes first. Insert immediately before that point.
5. If NOT found: determine alphabetical insertion position among existing `` `...`: `` headers. Insert a new group block at that position: blank line, `` `{context}`: ``, blank line, then the task line.

## Step 9: Compile PDF

Compile the weekly file to PDF:

```bash
cd "$NOTEBOX" && make weekly/YYYY-WNN
```

Where `YYYY-WNN` is the week identifier from Step 1. If the command fails, output:

```
Warning: PDF compilation failed for weekly/YYYY-WNN — check typst install
```

## Step 10: Confirm to user

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
- Does not write the `## Review` section — that belongs in the weekly skill
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
# 2026-W10

## Monday 2026-03-02

### Tasks

- [ ] Task three

`notebox`:

- [ ] Task one
- [x] Task two

### Notes

Observation or learning.

### References

- [Title](url) — one-sentence summary of why it's useful.

## Tuesday 2026-03-03

### Notes

Another observation.

## Review

### Completed

- Task two (Mon)

### Rolled over

- [ ] Task one — carried from Mon 2026-03-02
- [ ] Task three — carried from Mon 2026-03-02

### Promoted

- "Observation or learning." → reference/topic.md
```

Rules:

- Skip days and subsections with no content — no empty headings
- `## Review` is always last
- Notes are rough — polish belongs in reference files

</weekly_file_format>

<anti_patterns>

- ❌ Creating empty subsections (only create subsections when adding content)
- ❌ Rewriting the entire file (use Edit to append at insertion point)
- ❌ Skipping URL fetching (always get real title and write summary)
- ❌ Assuming task type from context when it could be a note (classify carefully)
- ❌ Using relative paths like `weekly/` — always use the full `$NOTEBOX/weekly/` path
- ❌ Appending tasks to the end of `### Tasks` without placing them in their context group
- ❌ Routing a project update to the weekly file (use the project file)

</anti_patterns>

<rationalizations>

These mean: use /capture anyway.

- "This is just a quick note" → still needs type detection and routing
- "I'll edit the file directly" → direct edits skip insertion order, polish, and routing rules
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
- [ ] Tasks use `- [ ]` (new), `- [-]` (started), or `- [x]` (done) prefix, imperative verb, no `(repo-name)` suffix — git repo context is expressed by the context group header, not a suffix
- [ ] References include a fetched title (or raw URL as fallback) and em-dash summary
- [ ] No empty subsections were created
- [ ] Completions: matching `- [ ]` or `- [-]` task found and changed to `- [x]`; conclusion appended as ` — _{conclusion}_` on the task line if present
- [ ] Started: matching `- [ ]` task found and changed to `- [-]`
- [ ] Cancellations: matching `- [ ]` or `- [-]` task found and changed to `- [/]`
- [ ] Project updates: target project matched, today's ## YYYY-MM-DD heading found or created, content appended under it
- [ ] The confirmation line was output to the user

</success_criteria>

<integration>

**Produces:** tasks/notes/references in day sections; project updates in `projects/YYYY.md`
**Consumed by:** daily (carries over tasks), weekly (reviews completed/incomplete tasks)
**Called after:** completing any task that originated from a notebox weekly file — use completion type to mark `- [ ]` → `- [x]`

</integration>
