---
name: branch
description: Generate and create a git branch name from session context
argument-hint: '[branch-name]'
allowed-tools:
  - Bash
  - Read
  - Grep
---

<objective>
Generate and create a git branch name from session context, Linear tickets, and current changes.

If branch name provided as argument, use it directly. Otherwise, infer from context.
</objective>

<arguments>
- **branch-name** (optional): Explicit branch name to use. If omitted, generates from context.
</arguments>

<process>
1. **Check for explicit name**
   - If argument provided, use it directly (skip to step 4)

2. **Gather context**
   - Review conversation to understand the task
   - Check `git status` and `git diff` for insight
   - Look for Linear ticket references in session
   - If no ticket found, use Linear MCP to check assigned/in-progress tickets

3. **Generate branch name**
   - See `<naming_rules>` for format

4. **Confirm and create**
   - Present suggested branch name with rationale
   - Ask "Create this branch?" and wait for confirmation
   - Run `git checkout -b <branch-name>`
   - Verify with `git branch --show-current`
     </process>

<naming_rules>
**With Linear ticket (preferred):**
`<team>-<number>-<description>`

- Use team identifier and issue number (e.g., `LIN-156`)
- Generate concise description from session context
- Keep description short and focused

**Without Linear ticket:**
`<type>/<description>`

- Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`
- Use kebab-case
- Keep under 50 characters
  </naming_rules>

<output_format>
Found Linear ticket LIN-156

Suggested branch: lin-156-dark-mode

Create this branch?
</output_format>

<success_criteria>

- [ ] Context gathered (git state, Linear tickets)
- [ ] Branch name follows naming rules
- [ ] User confirmed before creation
- [ ] Branch created and verified

</success_criteria>
