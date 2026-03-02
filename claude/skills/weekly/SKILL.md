---
name: weekly
model: haiku
description: Use at the end of a week or start of the next. Closes the previous week by summarizing completed tasks, rolling over incomplete tasks to Monday, promoting notes to reference files, and writing a Review section.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - Glob
---

<skill_overview>
End-of-week cycle: find the previous week's file, check it hasn't been reviewed yet, summarize completed tasks, roll incomplete tasks to the current week, let user approve note promotions, create the current week's file if missing, write Review section. HIGH RIGIDITY — follow steps in order. Interactive at step 5 (note promotion requires user confirmation).
</skill_overview>

<the_process>

## Step 1: Resolve file paths

Compute previous week and current week paths:

```bash
bun $SCRIPTS/claude/notebox.ts week-context
```

Example (run on 2026-03-09, a Monday of W11):
```
/home/sqve/notebox/weekly/2026-W10.md   ← week being reviewed
/home/sqve/notebox/weekly/2026-W11.md   ← week tasks roll into
2026-W10
2026-W11
```

**Stop conditions (check in order):**

1. If the previous week file does not exist: stop — "No file found for {prev_week_id}. Nothing to review."
2. If the previous week file already contains a `## Review` section: stop — "{prev_week_id} has already been reviewed."

## Step 2: Collect tasks from all day sections

Read the previous week file. Collect all task lines from day sections only (any `## ` heading with a day name, not `## AI suggestions` or `## Review`).

For each `- [x]` line: add to **completed** list (with the day name it came from).
For each `- [ ]` line: add to **incomplete** list with `[ ]` state (with the day name it came from).
For each `- [-]` line: add to **incomplete** list with `[-]` state (with the day name it came from).

Strip any existing `— carried from ...` labels when recording the task text — they will be regenerated if needed.

If no tasks exist anywhere (no `- [ ]` and no `- [x]`), skip steps 3 and 4.

## Step 3: Collect notes from day sections

Collect all prose lines from `### Notes` subsections in day sections. Exclude headings, blank lines, and task lines.

Group each note with the day section it came from (e.g., "Monday 2026-03-02").

If no notes exist, skip step 5.

## Step 4: Print task summary to user

Print before asking anything:

```
Weekly review for YYYY-WNN

Completed (N):
  ✓ Task text (Mon)
  ✓ Task text (Tue)

Incomplete (N):
  ○ Task text (Wed)
  ○ Task text (Thu)
```

## Step 5: Note promotion — ask user for each note

For each collected note (from step 3), present it to the user:

```
Note from {DayName}:
  "{note text}"

Promote? Enter:
  r <filename>  → reference/<filename>.md  (e.g. "r arch-linux")
  p <project>   → projects/ under project name  (e.g. "p notebox automation")
  (empty)       → skip
```

Wait for the user's response for each note before proceeding to the next.

**If user provides a filename (e.g. "arch-linux"):**

- Resolve path: `$NOTEBOX/reference/{filename}.md`
- Polish the note before writing: fix spelling and punctuation, remove filler phrases ("I think", "maybe", "probably", "seems like"), make sentences active and direct. Do not change the substance.
- If file exists: append polished note as a new paragraph at the end
- If file does not exist: create it with H1 matching the filename (title-case words), then the polished note
- Do not add timestamps or metadata

**If user presses Enter (empty input):** skip this note, do not write anywhere.

**If user enters `p <project>`:**

- Resolve the project file: `bun $SCRIPTS/claude/notebox.ts project-path`
- Polish the note before writing: fix spelling and punctuation, remove filler phrases ("I think", "maybe", "probably", "seems like"), make sentences active and direct. Do not change the substance.
- Read the project file. Fuzzy-match `<project>` to an H1 heading (case-insensitive, partial match). If no match, list existing project names and ask the user to clarify. If user wants a new project, ask for category and one-sentence description, then create the H1 + metadata line.
- Check if today's `## YYYY-MM-DD` heading exists under the matched project. Get today's date part from `bun $SCRIPTS/claude/notebox.ts today`.
- If today's heading exists: append the polished note after the last content line under it.
- If today's heading is missing: append at the end of the project section:
  ```
  ## YYYY-MM-DD

  {polished note}
  ```
- Do not add timestamps or metadata within the note itself.

After all notes, proceed to step 6.

## Step 6: Create current week's file if missing

Compute current week's Monday date:

```bash
bun $SCRIPTS/claude/notebox.ts week-monday
```

If current week's file does not exist, create it:

```markdown
# YYYY-WNN

## Monday YYYY-MM-DD

### Tasks

```

(H1 with the week identifier, then Monday section with empty Tasks subsection.)

## Step 7: Roll incomplete tasks to current week's Monday

For each incomplete task (collected in step 2), determine the source day name and date:

- Find the `## {DayName} {YYYY-MM-DD}` heading that contained the task
- Format origin label: `— carried from {DayName} {YYYY-MM-DD}` (e.g., `— carried from Wed 2026-03-04`)
  - Use abbreviated day: Mon, Tue, Wed, Thu, Fri, Sat, Sun

Insert each task into the correct context group in current week's Monday `### Tasks` section, using the original task prefix (`- [ ]` or `- [-]`):

```
- [ ] Task text — carried from Wed 2026-03-04
- [-] Started task — carried from Wed 2026-03-04
```

**Context group placement:** Extract the `(context-name)` suffix from the task text, before any ` — carried from` label. Use the same insertion algorithm as capture Step 8 — find or create the `` `{context}`: `` group sorted alphabetically, insert before the first `- [x]` in that group (or before the next group header, or at group end). Tasks with no context suffix go at the top of `### Tasks` without a header.

If a task already has a carry-over label, replace it with the new one (do not stack labels).

**Deduplication:** If an identical task text (ignoring carry-over labels) already exists in current week's Monday Tasks, skip it.

Do NOT rewrite the current week file. Use Edit to insert at the correct point.

## Step 7.5: Reading signal analysis

Scan the previous week file for reading items and captured URLs, then compute per-category capture rates.

**Collect reading items:**

Scan all day sections (`## DayName YYYY-MM-DD` headings) for `### Reading` subsections. For each subsection, extract:

- The URL from each `- [Title](URL)` list item (the portion inside the final `(...)`)
- The `**Category**` bold header immediately preceding it (scanning upward within the subsection); if none, group under "Uncategorized"

**Collect captured URLs:**

Scan all day sections for `### References` subsections. Extract all URLs from `- [Title](URL)` list items using the same pattern. Deduplicate: if the same URL appears more than once, count it once only.

**Skip condition:** if the previous week file has no `### Reading` subsections with list items, OR if total deduplicated captures = 0, skip this step entirely. Do not write `### Reading patterns`.

**Find overlap:** for each reading item URL, check whether it appears verbatim in the deduplicated captures list. Exact match only — do not normalize or strip query strings.

**Group by category:** for each category, count total reading items and how many of those URLs appear in captures.

**Write output:** if ≥1 capture found, compile the `### Reading patterns` block for use in Step 8:

```markdown
### Reading patterns

- Electronics: 1/2 captured (50%) ← consider boosting in feeds.md
- Hardware and making: 0/3 captured
- Neovim: 0/2 captured
```

Add `← consider boosting in feeds.md` only when the category meets both: capture rate ≥ 20% AND total reading items in that category ≥ 2. Do not add it for 1/1 = 100% (single-item categories are noise).

## Step 8: Write Review section in previous week file

Find or create `## Review` at the end of the previous week file (after `## AI suggestions` if it exists).

Write (overwrite if exists, append if missing):

```markdown
## Review

### Completed

- Task text (Mon)
- Task text (Tue)

### Rolled over

- [ ] Task text — carried from Wed 2026-03-04

### Promoted

- "{note text}" → reference/filename.md
- "{note text}" → projects/2026.md # Project Name

### Reading patterns

- Electronics: 1/2 captured (50%) ← consider boosting in feeds.md
- Neovim: 0/2 captured
```

Rules:
- `### Completed`: one `- ` line per completed task, with abbreviated day in parentheses. If none: write `None this week.`
- `### Rolled over`: one line per incomplete task using original prefix (`- [ ]` or `- [-]`) with carry-over label. If none: write `None.`
- `### Promoted`: one line per promoted note (reference or project). If none: omit this subsection entirely.
- `### Reading patterns`: include only if Step 7.5 found ≥1 capture. If Step 7.5 was skipped, omit this subsection entirely.

Do NOT rewrite the whole file. If `## Review` already exists, replace it entirely. Otherwise append at the end.

## Step 9: Compile PDF

For each file written in this skill run, compile to PDF. Run each make call separately:

1. Previous week file (always):
   ```bash
   cd "$NOTEBOX" && make weekly/YYYY-W(prev)
   ```

2. Current week file (always):
   ```bash
   cd "$NOTEBOX" && make weekly/YYYY-W(current)
   ```

3. Each reference file promoted in Step 5 (skip if none):
   ```bash
   cd "$NOTEBOX" && make reference/{filename}
   ```

4. Each project file promoted in Step 5 (skip if none):
   ```bash
   cd "$NOTEBOX" && make projects/YYYY
   ```
   Where `YYYY` is the current year.

Where targets are derived by stripping `.md` and the `$NOTEBOX/` prefix. If any call fails, output:

```
Warning: PDF compilation failed for <target> — check typst install
```

Do not stop on failure — compile remaining files.

## Step 10: Confirm to user

Output:

```
Weekly review complete — YYYY-WNN
  Completed: N tasks
  Rolled over: N tasks → YYYY-WNN Monday
  Promoted: N notes to reference/
  Current week file: {path} (created | already existed)
```

</the_process>

<error_handling>

**If `$NOTEBOX` is not set:** Stop. Report: "`NOTEBOX` environment variable is not set. Set it in your Claude settings.json env block."

**If previous week file does not exist:** Stop. Report: "No file found for {prev_week_id}. Nothing to review."

**If previous week file already has `## Review`:** Stop. Report: "{prev_week_id} has already been reviewed."

**If the previous week file is malformed** (wrong heading level, missing H1, corrupted structure): Do NOT attempt to repair. Notify the user and stop.

**If `notebox.ts` fails:** Ask the user: "What is today's date?"

**If reference file write fails:** Report the error and continue with the rest of the review. Do not abort.

**If current week file already exists:** Skip creation. Still roll tasks over to its Monday section.

**If current week file's Monday section already has content:** Append to it, do not overwrite.

</error_handling>

<weekly_file_format>

```markdown
# 2026-W10

## Monday 2026-03-02

### Tasks

`myrepo`:

- [ ] Task not done (myrepo)
- [x] Task completed (myrepo)

### Notes

Observation or learning.

### References

- [Title](url) — one-sentence summary.

## AI suggestions

Suggested reading: [Title](url) — why it might be relevant.

## Review

### Completed

- Task completed (Mon)

### Rolled over

- [ ] Task not done — carried from Mon 2026-03-02

### Promoted to reference

- "Observation or learning." → reference/topic.md
```

Rules:
- `## Review` is always the last section
- `## AI suggestions` comes before `## Review`, after all day sections
- Promoted-to-reference subsection is omitted if nothing was promoted

</weekly_file_format>

<anti_patterns>

- ❌ Promoting notes without user confirmation (step 5 requires explicit approval per note)
- ❌ Stacking carry-over labels (`— carried from Mon — carried from Tue`) — replace, don't stack
- ❌ Rewriting the whole file — use Edit to insert/replace at the correct point only
- ❌ Creating empty subsections in the Review section — omit `### Promoted to reference` if none
- ❌ Using relative paths — always use the full `$NOTEBOX/weekly/` path
- ❌ Promoting notes to day sections — promotions go only to `$NOTEBOX/reference/*.md` or `$NOTEBOX/projects/YYYY.md`
- ❌ Reviewing the current week — always review the previous week's file
- ❌ Running if previous week file has already been reviewed — check for `## Review` first
- ❌ Writing `### Reading patterns` when total captures = 0 — creates noise in weeks with no captures; step 7.5 must be skipped entirely
- ❌ Adding "← consider boosting" for categories with fewer than 2 reading items that week — 1/1 = 100% is noise, not signal

</anti_patterns>

<success_criteria>

- [ ] `$NOTEBOX` resolved and path is valid
- [ ] Previous week file found and has no existing `## Review` section
- [ ] Previous week file scanned — completed and incomplete tasks both collected
- [ ] User was shown each note and asked whether to promote it
- [ ] Promoted notes written to correct destination: `$NOTEBOX/reference/*.md` or `$NOTEBOX/projects/YYYY.md` depending on user's choice
- [ ] Current week file exists at correct path (created or already present)
- [ ] Current week Monday `### Tasks` contains all rolled-over incomplete tasks with carry-over labels, placed in correct `` `context`: `` groups (alphabetical, general at top); `- [-]` tasks preserve `- [-]` prefix (not reset to `- [ ]`)
- [ ] No duplicate tasks in current week Monday (deduplication applied)
- [ ] `## Review` section written at end of previous week file with Completed, Rolled over subsections
- [ ] `### Promoted` subsection present only if at least one note was promoted
- [ ] Step 7.5 skipped (no `### Reading patterns` written) when previous week has no reading items or zero captures; `### Reading patterns` appears in `## Review` only when ≥1 capture found
- [ ] Summary printed to user

</success_criteria>

<integration>

**Reads:** all day sections and `## AI suggestions` from the previous week's file (written by capture and daily throughout the week)
**Produces:** `## Review` section in the previous week file; incomplete tasks rolled to current week's Monday `### Tasks`; promoted notes written to `$NOTEBOX/reference/*.md` or `$NOTEBOX/projects/YYYY.md`
**Consumed by:** nothing — terminal step in the weekly cycle

</integration>
