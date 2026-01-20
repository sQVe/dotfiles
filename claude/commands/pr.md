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
   - Check coverage: happy path, edge cases, integration points, regression risks
   - If gaps found: add missing items before proceeding

6. **Execute test plan**
   - Parse test plan checkboxes
   - Identify automatable items:
     - Commands: backticked like `npm test`
     - URLs: paths like `/dashboard`
   - Execute and update checkboxes: `[x]` passed, `[ ]` failed/manual
   - If any automatable check fails: mark as `[ ]`, report failure details, and ask user whether to proceed or abort
   - Report results before proceeding

7. **Confirm** (skip if `--no-confirm`)
   - Output PR title and full description BEFORE asking
   - Then use `AskUserQuestion` with options:
     - **Create PR** — publish immediately
     - **Create draft** — publish as draft for preview
     - **Edit** — revise title or description
     - **Cancel** — abort

8. **Create PR** (fix loop, max 3 attempts)
   - Run `gh pr create` with title and body
   - If creation fails (push rejected, conflicts):
     - Analyze failure output
     - Auto-fix if possible (rebase, push)
     - Re-attempt creation
     - After 3 failures: report issues, ask user to fix manually
   - Capture PR URL on success

9. **Add references and report**
   - Link relevant issues and PRs
   - Add appropriate reviewers
   - Output PR URL and summary
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
- [ ] Automatable test plan items executed
- [ ] User confirmed (unless --no-confirm)
- [ ] PR created with references

</success_criteria>
