---
name: triage
description: Triage AI suggestions in notebox weekly files. Promotes to reference/*.md, keeps in today's tasks, or rejects each item interactively.
allowed-tools:
  - Bash
  - Read
  - Edit
  - Glob
  - AskUserQuestion
---

<skill_overview>
Interactive review of AI-written content across weekly files. Finds all ## AI suggestions sections (current week first), presents each item one at a time, and executes the user's choice: promote to reference/*.md, keep in today's day section, or reject. Cleans up empty sections after review. HIGH RIGIDITY — one item at a time, targeted edits only.
</skill_overview>

<the_process>

## Step 1: Resolve paths

```bash
python3 -c "
import os
from datetime import date
d = date.today()
iso = d.isocalendar()
notebox = os.environ.get('NOTEBOX', '')
if not notebox:
    raise SystemExit('NOTEBOX environment variable is not set')
print(notebox)
print(f'{notebox}/weekly/{iso[0]}-W{iso[1]:02d}.md')
print(d.strftime('%A %Y-%m-%d'))
"
```

Output is three lines: NOTEBOX path, current weekly file path, today's day name and date (e.g. `Monday 2026-03-02`).

## Step 2: Find weekly files with AI suggestions

List all weekly files, newest first:

```bash
ls -t $NOTEBOX/weekly/*.md 2>/dev/null
```

Read each file. Collect those that have a `## AI suggestions` section with at least one non-blank content line below it.

Process current week first, then past weeks in descending order.

## Step 3: Extract items

For each collected file, find the `## AI suggestions` section. Extract individual items — each is one line matching one of these prefixes:

| Prefix | Type |
|--------|------|
| `- [ ] (suggested) ` | task |
| `Note: ` | note |
| `Suggested reading: ` | reference |

Skip blank lines and lines not matching any prefix. Tag each item with: `source_file`, `raw_line`, `type`.

If no items found across all files, output: "No AI suggestions found." and stop.

## Step 4: Present each item and execute action

For each item in order:

1. Display the item content clearly (show the raw line).
2. Use `AskUserQuestion` with:
   - **Promote** — move to reference/*.md
   - **Keep** — move to today's day section
   - **Reject** — discard

Execute the action (Step 5) before moving to the next item.

## Step 5: Execute action

### Promote

1. Infer the target reference file from the item content. Match against existing files in `$NOTEBOX/reference/`:

   | Topic | File |
   |-------|------|
   | Coding, programming, algorithms, APIs | `coding.md` |
   | Command-line, shell, terminal, tools | `command-line.md` |
   | Electronics, hardware, PCB, circuits | `electronics.md` |
   | Lab, science, experiments, measurement | `lab.md` |
   | Security, cryptography, vulnerabilities | `security.md` |
   | Arch Linux, pacman, system setup | `arch-linux.md` |

   If the topic doesn't match any known file, use `AskUserQuestion` and list existing files in `$NOTEBOX/reference/` with a "New file" option. For "New file", ask for the filename (without `.md`).

2. Format and polish the content for the reference file:
   - task: strip `(suggested)` → `- [ ] <task text>` (make imperative, strip filler)
   - note: strip `Note: ` → plain paragraph text (fix spelling/punctuation, remove filler phrases like "I think", "maybe", "probably", keep substance intact)
   - reference: strip `Suggested reading: ` → `- [Title](url) — summary.`

3. Read the target reference file. Append the formatted content at the most semantically appropriate location:
   - For a note or task: find the most relevant H2 section header and append before the next H2
   - For a reference link: append after the last existing `- [` link in the file, or at the end
   - When unsure: append at the end of the file

4. Remove the item's raw line from the source file's `## AI suggestions` section using Edit (exact line match).

### Keep

1. Strip the type prefix, polish, and format for the weekly file:
   - task: `- [ ] (suggested) Fix the login bug` → `- [ ] Fix the login bug` (make imperative, strip filler)
   - note: `Note: Cache issue likely.` → `Cache issue likely.` (fix spelling/punctuation, remove filler phrases like "I think", "maybe", "probably")
   - reference: `Suggested reading: [Title](url) — summary.` → `- [Title](url) — summary.`

2. Target subsection by type: task → `### Tasks`, note → `### Notes`, reference → `### References`.

3. Open the current weekly file (from Step 1). Find today's day section (`## {DayName} YYYY-MM-DD`). If missing, create it — insert before `## AI suggestions` if that section exists, otherwise at the end.

4. Find or create the target subsection within today's section. Maintain order: Tasks → Notes → References. Append the formatted content at the end of the target subsection (before the next `###` or `##` heading).

5. Remove the item's raw line from the source file's `## AI suggestions` section using Edit.

### Reject

Remove the item's raw line from the source file's `## AI suggestions` section using Edit. No other action.

## Step 6: Clean up empty AI suggestions sections

After processing all items from a file, re-read the file. If the `## AI suggestions` section exists but contains no content lines (only blank lines between the header and the next `##` or EOF), remove the section header line and the following blank lines using Edit.

Do NOT rewrite the entire file.

## Step 7: Summary

```
Reviewed N items: M promoted, K kept, J rejected
```

If items came from multiple files, list each: `(2 from 2026-W10.md, 1 from 2026-W09.md)`.

</the_process>

<error_handling>

**If `$NOTEBOX` is not set:** Stop. Report: "`NOTEBOX` environment variable is not set."

**If no weekly files exist:** Output: "No weekly files found in `$NOTEBOX/weekly/`." and stop.

**If a reference file doesn't exist for a new file:** Create it with `# Title\n\n` where Title is the filename in title case.

**If today's day section is missing for 'keep':** Create `## {DayName} YYYY-MM-DD` before `## AI suggestions`. If `## AI suggestions` doesn't exist in the current file, append the new day section at the end.

**If a weekly file is malformed:** Skip it and report which file was skipped.

**If Edit fails to find the exact line to remove:** Report the failure and show the unremoved item so the user can handle it manually.

</error_handling>

<anti_patterns>

- ❌ Processing multiple items before asking for user decision (one at a time, always)
- ❌ Leaving empty `## AI suggestions` headers after review completes
- ❌ Rewriting entire files — targeted Edit only
- ❌ Carrying the `(suggested)` label into day sections or reference files
- ❌ Skipping topic inference — always attempt before asking user
- ❌ Creating new reference files without asking for the filename

</anti_patterns>

<success_criteria>

- [ ] `$NOTEBOX` resolved and valid
- [ ] All weekly files scanned for AI suggestions
- [ ] Each item presented one at a time with clear options
- [ ] Promote writes clean content (no type-label prefix) to correct reference file
- [ ] Keep writes clean content to today's correct subsection in the current weekly file
- [ ] Reject removes item without leaving a blank line trace
- [ ] Empty `## AI suggestions` sections removed (no orphaned headers)
- [ ] Summary printed to user

</success_criteria>
