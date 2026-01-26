---
name: pr
description: Create a pull request with description and test plan
argument-hint: '[--no-confirm] [pr-title]'
model: claude-opus-4-5-20251101
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

<objective>
Create a pull request with clear description and actionable test plan.

Runs automatable test plan items before creating the PR.
</objective>

<arguments>
- **--no-confirm** (optional): Skip confirmation prompt
- **pr-title** (optional): Explicit PR title to use
</arguments>

<context_injection>
@/home/sqve/.dotfiles/claude/templates/pr-template.md
</context_injection>

<process>
1. **Validate prerequisites**
   - Run `git rev-parse --abbrev-ref HEAD` — if `main` or `master`: "Create a feature branch first"
   - If validation fails: stop with clear message

2. **Prepare branch**
   - Verify all changes committed and pushed
   - Check branch is up-to-date with target (main/master)

3. **Check contribution requirements**
   - Look for CONTRIBUTING.md, CHANGELOG.md, .changeset/
   - Add required artifacts:
     - If CHANGELOG.md exists and has "Unreleased" section, add entry
     - If .changeset/ exists, run `npx changeset` interactively
     - If neither, skip

4. **Create PR description**
   - Use conventional commit format for title
   - Follow injected template structure
   - Link related issues with "Fixes #" or "Related to #"

5. **Verify test plan coverage**
   - Review the diff and list key behaviors/paths affected
   - Categorize items:
     - **Checkboxes**: Commands, verifiable behaviors, automatable checks
     - **Manual verification**: Visual/UX, post-merge (CI), external systems
   - If items are miscategorized: move to correct section
   - Check coverage: happy path, edge cases, integration points, regression risks
   - If gaps found: add missing items before proceeding

6. **Present test plan** (OUTPUT GATE)
   - Parse test plan checkboxes
   - Identify automatable items:
     - Commands: backticked like `npm test`
     - URLs: paths like `/dashboard`
   - Output test plan showing which items are automatable
   - Output PR title and full description
   - End output with `---` separator
   - **PROHIBITED after separator:**
     - "Let me...", "I'll...", "Now I will..."
     - "Starting with...", "First I'll..."
     - Any action-announcing language
   - Proceed directly to Confirm step

7. **Confirm** (skip if `--no-confirm`)
   - IMMEDIATELY use `AskUserQuestion` with options:
     - **Create PR** — run tests and publish immediately
     - **Create draft** — run tests and publish as draft for preview
     - **Edit** — revise title or description
     - **Cancel** — abort

8. **Execute test plan**
   - Execute all checkbox items
   - Update checkboxes: `[x]` passed, `[ ]` failed
   - If ANY checkbox fails:
     - Report failure details
     - Ask user: **Fix and retry** or **Cancel**
     - Do NOT proceed with unchecked items

9. **Validate test plan completion**
   - Verify ALL checkboxes are `[x]`
   - If any remain `[ ]`: block PR creation, return to step 8
   - Manual verification section: no validation (informational only)

10. **Create PR** (fix loop, max 3 attempts)
   - Run `gh pr create` with title and body
   - If creation fails (push rejected, conflicts):
     - Analyze failure output
     - Auto-fix if possible (rebase, push)
     - Re-attempt creation
     - After 3 failures: report issues, ask user to fix manually
   - Capture PR URL on success

11. **Add references and report**
   - Link relevant issues and PRs
   - Add appropriate reviewers
   - Output PR URL and summary

<anti_patterns>
After presenting findings, NEVER:
- "Let me create/start/begin..."
- "I'll now..."
- "Starting with the first..."
- "Now I will..."
- Announcing intent before user chooses action
</anti_patterns>
</process>

<output_format>

```
✓ PR created: {pr_url}

{title}

Test plan: {passed}/{total} checks passed
```

---

## ▶ Next Up

**Monitor PR** — wait for CI and reviews

`gh pr checks` — view CI status

---

**Also available:**

- `gh pr view --web` — open PR in browser
- `/annotate` — add self-review comments

---

</output_format>

<tone>
Use the `elements-of-style:writing-clearly-and-concisely` skill.

Write as if explaining to a colleague who knows the domain but not this code.

**Do:**

- "feat: switch to JWT for stateless sessions"
- "fix: resolve race condition in checkout by locking cart state"

**Don't:**

- Stiff: "This PR implements a refactored authentication layer"
- Casual: "Hey! Threw together some auth stuff"
- Padding: "As you can see, I've made some changes that..."

No exclamation marks. No emojis. Lead with the change, not preamble.
</tone>

<success_criteria>

- [ ] Branch prepared and pushed
- [ ] Contribution requirements met
- [ ] PR description follows structure
- [ ] Test plan verified for coverage gaps
- [ ] User confirmed (unless --no-confirm)
- [ ] All test plan checkboxes verified `[x]`
- [ ] PR created with references

</success_criteria>
