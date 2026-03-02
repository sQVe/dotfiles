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

Read the previous week file. Collect all task lines from day sections only (any `## ` heading with a day name, not `## Review`).

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

Scan the previous week file for surviving reading items and captured URLs to compile the `### Reading patterns` block.

**Collect reading items:**

Scan all day sections (`## DayName YYYY-MM-DD` headings) for `### Reading` subsections. For each subsection, extract:

- The URL from each `- [Title](URL)` list item (the portion inside the final `(...)`)
- The `**Category**` bold header immediately preceding it (scanning upward within the subsection); if none, group under "Uncategorized"

**Shared skip condition:** if the previous week file has no `### Reading` subsections with list items, skip this step entirely. Do not write `### Reading patterns`.

**Capture-rate analysis:**

Scan all day sections for `### References` subsections. Extract all URLs from `- [Title](URL)` list items using the same pattern. Deduplicate: if the same URL appears more than once, count it once only. If total deduplicated captures = 0, skip capture-rate analysis.

Otherwise: for each reading item URL, check whether it appears verbatim in the deduplicated captures list (exact match — do not normalize or strip query strings). Group by category: count total reading items per category and how many appeared in captures. Compile capture-rate lines:

```markdown
- Electronics: 1/2 captured (50%) ← consider boosting in feeds.md
- Hardware and making: 0/3 captured
- Neovim: 0/2 captured
```

Add `← consider boosting in feeds.md` only when the category meets both: capture rate ≥ 20% AND total reading items in that category ≥ 2. Do not add it for 1/1 = 100% (single-item categories are noise).

**Surviving-items analysis:**

Count reading items per category. Normalize category names: strip trailing colons and whitespace from bold headers; treat case-insensitively (merge `**Neovim:**` and `**neovim:**` into one key, keeping the first casing seen). Discard categories with <2 items.

If ≥1 category has ≥2 items, compile kept lines:

```markdown
- Neovim: 8 kept
- Electronics: 3 kept
```

Use the word `kept`. List in descending order by count.

**Write output:** if capture-rate lines OR kept lines were compiled, assemble the `### Reading patterns` block for use in Step 8. Capture-rate lines appear first, then kept lines; no separator between them:

```markdown
### Reading patterns

- Electronics: 1/2 captured (50%) ← consider boosting in feeds.md
- Neovim: 0/3 captured
- Neovim: 3 kept
```

**Interests update proposal:**

Skip this sub-step entirely if no kept lines were compiled (surviving-items analysis found no category with ≥2 items). Also skip if `$NOTEBOX/reference/interests.md` does not exist — print "Warning: interests.md not found — skipping interests update proposal" and proceed to Step 8.

Read `$NOTEBOX/reference/interests.md`. For each kept category, check whether any bullet line under `## Topics I care about` contains the category name as a case-insensitive substring (e.g., kept category "CLI tools" matches "- CLI tools: CLIs, TUIs, productivity tooling"). Covered = ≥1 bullet contains the category name; uncovered = no match.

If all kept categories are covered: print "Reading signal matches current interests — no updates needed." Proceed to Step 8 without prompting.

If ≥1 uncovered category, present a proposal:

```
Reading signal this week:
  Neovim: 8 kept
  CLI tools: 3 kept

Proposed additions to interests.md:
  + "CLI tools: CLIs, TUIs, productivity tooling" (suggested text — edit as needed)

Apply? (y/n)
```

Show ALL kept lines in the signal section (including covered ones). Show only uncovered categories in "Proposed additions". For each proposed addition, suggest text using the category name plus a brief placeholder description. Wait for user response:

- `y`: append each proposed addition as a new bullet line under `## Topics I care about` using Edit (do NOT rewrite the whole file), then run `cd "$NOTEBOX" && make reference/interests`. If write fails: print "Warning: Failed to update interests.md — check file permissions" and proceed to Step 8. If PDF compile fails: print "Warning: PDF compilation failed for reference/interests — check typst install" and proceed to Step 8.
- Anything other than `y`: print "Skipping interests.md update." and proceed to Step 8. Do not re-prompt.

## Step 8: Write Review section in previous week file

Find or create `## Review` at the end of the previous week file.

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
- `### Reading patterns`: include if Step 7.5 compiled any capture-rate or kept lines. If Step 7.5 was skipped (no reading items), omit this subsection entirely.

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
- ❌ Writing `### Reading patterns` when no `### Reading` items exist — step 7.5 must be skipped entirely when the week has no reading section
- ❌ Adding "← consider boosting" for categories with fewer than 2 reading items that week — 1/1 = 100% is noise, not signal
- ❌ Adding kept lines for a category with only 1 surviving item — noise threshold is 2
- ❌ Auto-applying changes to `interests.md` — user must confirm every proposed edit
- ❌ Suggesting removals or deprioritizations from interests.md — kept signal is positive only; absence is ambiguous
- ❌ Running the interests update proposal when no kept lines were compiled (signal must exist before prompting)
- ❌ Adding duplicate entries to interests.md — coverage check (case-insensitive substring) must pass before proposing
- ❌ Rewriting the whole interests.md file — append only under `## Topics I care about` using Edit

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
- [ ] Step 7.5 skipped entirely when previous week has no `### Reading` items; `### Reading patterns` written to `## Review` when ≥1 capture-rate or kept line was compiled
- [ ] Surviving reading items counted per category (case-insensitive, trailing colons stripped); categories with <2 items excluded from kept lines
- [ ] Kept lines appear in `### Reading patterns` using the word `kept`, in descending order by count, after any capture-rate lines
- [ ] Interests update proposal sub-step skipped when no kept lines were compiled
- [ ] Coverage check uses case-insensitive substring match against bullets in `## Topics I care about`
- [ ] Proposal shows full kept signal + only uncovered categories in "Proposed additions"
- [ ] User prompted with `y/n` before any write to interests.md; unexpected input treated as `n`
- [ ] Approved additions appended under `## Topics I care about` via Edit (no full file rewrite); interests.md compiled to PDF after write
- [ ] Write/compile failures produce warnings but do not abort the weekly review
- [ ] Summary printed to user

</success_criteria>

<integration>

**Reads:** all day sections from the previous week's file (written by capture and daily throughout the week)
**Produces:** `## Review` section in the previous week file; incomplete tasks rolled to current week's Monday `### Tasks`; promoted notes written to `$NOTEBOX/reference/*.md` or `$NOTEBOX/projects/YYYY.md`
**Consumed by:** nothing — terminal step in the weekly cycle

</integration>
