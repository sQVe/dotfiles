---
name: pr
description: Create a pull request with description and test plan
argument-hint: '[--no-confirm] [pr-title]'
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
1. **Prepare branch**
   - Verify all changes committed and pushed
   - Check branch is up-to-date with target (main/master)

2. **Check contribution requirements**
   - Look for CONTRIBUTING.md, CHANGELOG.md, .changeset/
   - Add required artifacts if missing

3. **Create PR description**
   - Use conventional commit format for title
   - Structure per `<pr_structure>`
   - Link related issues with "Fixes #" or "Related to #"

4. **Execute test plan**
   - Parse test plan checkboxes
   - Identify automatable items:
     - Commands: backticked like `npm test`
     - URLs: paths like `/dashboard`
   - Execute and update checkboxes: `[x]` passed, `[ ]` failed/manual
   - Report results before proceeding

5. **Confirm** (skip if `--no-confirm`)
   - Present complete PR title and description
   - Ask "Ready to create this PR?"
   - Use `--draft` for reviewer preview

6. **Add references**
   - Link relevant issues and PRs
   - Add appropriate reviewers
</process>

<pr_structure>

## Summary

1-2 sentences on what and why.

## Changes

- 3-5 bullet points of key technical changes

## Test plan

- [ ] Automatable checks (commands, URLs)
- [ ] Manual verification items

**Never include:** CI status, review gates, merge status
</pr_structure>

<tone>
Use the `elements-of-style:writing-clearly-and-concisely` skill.

Write as if explaining to a colleague who knows the domain but not this code.

**Do:**
- "Switches to JWT for stateless sessions"
- "Fixes race condition in checkout by locking cart state"

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
- [ ] Automatable test plan items executed
- [ ] User confirmed (unless --no-confirm)
- [ ] PR created with references

</success_criteria>
