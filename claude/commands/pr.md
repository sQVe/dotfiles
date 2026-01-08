# PR Command

Create a pull request with clear description and test plan.

## Usage

```
/pr [pr-title]
```

## Instructions

1. **Prepare branch**
   - Verify all changes are committed and pushed
   - Check branch is up-to-date with target branch (main/master)

2. **Check contribution requirements**
   - Look for CONTRIBUTING.md, CHANGELOG.md, or .changeset/ directory
   - Add required artifacts (changeset, release notes) if missing

3. **Create PR description**
   - Use [PR template](/home/sqve/.dotfiles/claude/templates/pr-template.md) for format
   - Use conventional commit format for title (feat:, fix:, docs:, etc.)
   - Structure description with: Summary, Changes, Test plan
   - Summarize key technical changes with 3-5 bullet points
   - Add actionable test plan with checkboxes (things verifiable before PR creation)
   - Never include CI status, review gates, or merge status in test plan
   - Link related issues with "Fixes #" or "Related to #"

4. **Execute test plan**
   - Parse test plan checkboxes from the description
   - Identify automatable items:
     - Command items: backticked commands like `npm test`, `make build`
     - URL items: paths like `/dashboard`, endpoints to verify
   - Execute automatable items:
     - Run commands via bash and check exit codes
     - Use browser automation for URL verification when applicable
   - Update checkboxes: `[x]` for passed, `[ ]` for failed or manual
   - Report results before proceeding

5. **Approval process**
   - Present complete PR title and description
   - Ask "Ready to create this PR?" and wait for confirmation
   - Make revisions based on feedback
   - Use `--draft` so reviewers can preview before finalizing

6. **Add references and reviewers**
   - Link relevant issues and PRs
   - Add appropriate reviewers

## Examples

```bash
# Create PR for current branch
/pr

# Create PR with specific title
/pr "feat: add user authentication system"
```
