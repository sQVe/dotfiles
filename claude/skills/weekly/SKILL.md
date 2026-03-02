---
name: weekly
description: End-of-week review skill. Closes the week by summarizing completed tasks, rolling over incomplete tasks to next week's Monday, promoting notes to reference files, creating next week's file, and writing a Review section. Run once at the end of each week.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - Glob
---

<skill_overview>
End-of-week cycle: scan current week file, summarize completed tasks, roll incomplete tasks to next week, let user approve note promotions, create next week's file, write Review section. HIGH RIGIDITY — follow steps in order. Interactive at step 5 (note promotion requires user confirmation).
</skill_overview>

<the_process>

## Step 1: Resolve file paths

Get current and next week paths:

```bash
python3 -c "
import os
from datetime import date, timedelta
d = date.today()
iso = d.isocalendar()
next_week = d + timedelta(weeks=1)
next_iso = next_week.isocalendar()
notebox = os.environ.get('NOTEBOX', '')
if not notebox:
    raise SystemExit('NOTEBOX environment variable is not set')
print(f'{notebox}/weekly/{iso[0]}-W{iso[1]:02d}.md')
print(f'{notebox}/weekly/{next_iso[0]}-W{next_iso[1]:02d}.md')
"
```

Example:
```
/home/sqve/notebox/weekly/2026-W10.md
/home/sqve/notebox/weekly/2026-W11.md
```

If the current weekly file does not exist, stop: "No current weekly file found at {path}. Nothing to review."

## Step 2: Collect tasks from all day sections

Read the current weekly file. Collect all task lines from day sections only (any `## ` heading with a day name, not `## AI suggestions` or `## Review`).

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
- If file exists: append note as a new paragraph at the end
- If file does not exist: create it with H1 matching the filename (title-case words), then the note
- Do not add timestamps or metadata

**If user presses Enter (empty input):** skip this note, do not write anywhere.

After all notes, proceed to step 6.

## Step 6: Create next week's file if missing

Compute next week's Monday date:

```bash
python3 -c "
from datetime import date, timedelta
d = date.today()
# Find next Monday
days_until_monday = (7 - d.weekday()) % 7
if days_until_monday == 0:
    days_until_monday = 7
monday = d + timedelta(days=days_until_monday)
print(monday.strftime('%A %Y-%m-%d'))
"
```

If next week's file does not exist, create it:

```markdown
# YYYY-WNN

## Monday YYYY-MM-DD

### Tasks

```

(H1 with the week identifier, then Monday section with empty Tasks subsection.)

## Step 7: Roll incomplete tasks to next week's Monday

For each incomplete task (collected in step 2), determine the source day name and date:

- Find the `## {DayName} {YYYY-MM-DD}` heading that contained the task
- Format origin label: `— carried from {DayName} {YYYY-MM-DD}` (e.g., `— carried from Wed 2026-03-04`)
  - Use abbreviated day: Mon, Tue, Wed, Thu, Fri, Sat, Sun

Append to next week's Monday `### Tasks` section:

```
- [ ] Task text — carried from Wed 2026-03-04
```

If a task already has a carry-over label, replace it with the new one (do not stack labels).

**Deduplication:** If an identical task text (ignoring carry-over labels) already exists in next week's Monday Tasks, skip it.

Do NOT rewrite the next week file. Use Edit to append at the correct insertion point.

## Step 8: Write Review section in current week file

Find or create `## Review` at the end of the current week file (after `## AI suggestions` if it exists).

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
  Next week file: {path} (created | already existed)
```

</the_process>

<error_handling>

**If `$NOTEBOX` is not set:** Stop. Report: "`NOTEBOX` environment variable is not set. Set it in your Claude settings.json env block."

**If current weekly file does not exist:** Stop. Report: "No current weekly file found at {path}. Nothing to review."

**If the current weekly file is malformed** (wrong heading level, missing H1, corrupted structure): Do NOT attempt to repair. Notify the user and stop.

**If python3 fails:** Ask the user: "What is today's date?"

**If reference file write fails:** Report the error and continue with the rest of the review. Do not abort.

**If next week file already exists:** Skip creation. Still roll tasks over to its Monday section.

**If next week file's Monday section already has content:** Append to it, do not overwrite.

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
- ❌ Running if no current week file exists — check first, stop if missing

</anti_patterns>

<success_criteria>

- [ ] `$NOTEBOX` resolved and path is valid
- [ ] Current week file scanned — completed and incomplete tasks both collected
- [ ] User was shown each note and asked whether to promote it
- [ ] Promoted notes written to correct `$NOTEBOX/reference/*.md` file
- [ ] Next week file exists at correct path (created or already present)
- [ ] Next week Monday `### Tasks` contains all rolled-over incomplete tasks with carry-over labels
- [ ] No duplicate tasks in next week Monday (deduplication applied)
- [ ] `## Review` section written at end of current week file with Completed, Rolled over subsections
- [ ] `### Promoted to reference` subsection present only if at least one note was promoted
- [ ] Summary printed to user

</success_criteria>
