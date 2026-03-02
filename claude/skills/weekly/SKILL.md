---
name: weekly
description: End-of-week review skill. Closes the week by summarizing completed tasks, rolling over incomplete tasks to the current week's Monday, promoting notes to reference files, creating the current week's file, and writing a Review section. Run once at the end of a week or start of the next. Always reviews the previous week.
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
python3 -c "
import os
from datetime import date, timedelta
d = date.today()
prev_week = d - timedelta(weeks=1)
prev_iso = prev_week.isocalendar()
curr_iso = d.isocalendar()
notebox = os.environ.get('NOTEBOX', '')
if not notebox:
    raise SystemExit('NOTEBOX environment variable is not set')
print(f'{notebox}/weekly/{prev_iso[0]}-W{prev_iso[1]:02d}.md')
print(f'{notebox}/weekly/{curr_iso[0]}-W{curr_iso[1]:02d}.md')
print(f'{prev_iso[0]}-W{prev_iso[1]:02d}')
print(f'{curr_iso[0]}-W{curr_iso[1]:02d}')
"
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
For each `- [ ]` line: add to **incomplete** list (with the day name it came from).

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

Promote to reference/? Enter a filename (e.g. "arch-linux") to promote, or press Enter to skip.
```

Wait for the user's response for each note before proceeding to the next.

**If user provides a filename (e.g. "arch-linux"):**

- Resolve path: `$NOTEBOX/reference/{filename}.md`
- Polish the note before writing: fix spelling and punctuation, remove filler phrases ("I think", "maybe", "probably", "seems like"), make sentences active and direct. Do not change the substance.
- If file exists: append polished note as a new paragraph at the end
- If file does not exist: create it with H1 matching the filename (title-case words), then the polished note
- Do not add timestamps or metadata

**If user presses Enter (empty input):** skip this note, do not write anywhere.

After all notes, proceed to step 6.

## Step 6: Create current week's file if missing

Compute current week's Monday date:

```bash
python3 -c "
from datetime import date, timedelta
d = date.today()
days_since_monday = d.weekday()
monday = d - timedelta(days=days_since_monday)
print(monday.strftime('%A %Y-%m-%d'))
"
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

Append to current week's Monday `### Tasks` section:

```
- [ ] Task text — carried from Wed 2026-03-04
```

If a task already has a carry-over label, replace it with the new one (do not stack labels).

**Deduplication:** If an identical task text (ignoring carry-over labels) already exists in current week's Monday Tasks, skip it.

Do NOT rewrite the current week file. Use Edit to append at the correct insertion point.

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

### Promoted to reference

- "{note text}" → reference/filename.md
```

Rules:
- `### Completed`: one `- ` line per completed task, with abbreviated day in parentheses. If none: write `None this week.`
- `### Rolled over`: one `- [ ]` line per incomplete task with carry-over label. If none: write `None.`
- `### Promoted to reference`: one line per promoted note. If none: omit this subsection entirely.

Do NOT rewrite the whole file. If `## Review` already exists, replace it entirely. Otherwise append at the end.

## Step 9: Confirm to user

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

**If python3 fails:** Ask the user: "What is today's date?"

**If reference file write fails:** Report the error and continue with the rest of the review. Do not abort.

**If current week file already exists:** Skip creation. Still roll tasks over to its Monday section.

**If current week file's Monday section already has content:** Append to it, do not overwrite.

</error_handling>

<weekly_file_format>

```markdown
# 2026-W10

## Monday 2026-03-02

### Tasks

- [x] Task completed
- [ ] Task not done

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
- ❌ Promoting notes to day sections — promotions go only to `$NOTEBOX/reference/*.md` files
- ❌ Reviewing the current week — always review the previous week's file
- ❌ Running if previous week file has already been reviewed — check for `## Review` first

</anti_patterns>

<success_criteria>

- [ ] `$NOTEBOX` resolved and path is valid
- [ ] Previous week file found and has no existing `## Review` section
- [ ] Previous week file scanned — completed and incomplete tasks both collected
- [ ] User was shown each note and asked whether to promote it
- [ ] Promoted notes written to correct `$NOTEBOX/reference/*.md` file
- [ ] Current week file exists at correct path (created or already present)
- [ ] Current week Monday `### Tasks` contains all rolled-over incomplete tasks with carry-over labels
- [ ] No duplicate tasks in current week Monday (deduplication applied)
- [ ] `## Review` section written at end of previous week file with Completed, Rolled over subsections
- [ ] `### Promoted to reference` subsection present only if at least one note was promoted
- [ ] Summary printed to user

</success_criteria>
