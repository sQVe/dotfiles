# PR Command

Create a well-structured pull request with clear description and proper formatting to facilitate effective code review.

## Usage

```
/pr [pr-title]
```

## Instructions

You are helping create a comprehensive pull request. Follow these steps:

1. **Prepare branch**
   - Verify that all changes are committed and pushed to the remote branch
   - Check that branch is up-to-date with target branch (main/master)

2. **Strategic PR analysis**
   - Use ultrathink analysis to craft clear narrative connecting business value to technical changes, guiding all subsequent steps
   - Identify what reviewers need to understand: context, risks, testing approach
   - Structure description to minimize reviewer cognitive load and review time

3. **Create PR description**
   - Use [PR template](../templates/pr-template.md) for PR format.
   - Use conventional commit format for title (feat:, fix:, docs:, etc.)
   - Structure description with: Summary, Changes, Test Plan
   - Summarize key technical changes in Changes section with 3-5 focused bullet points maximum
   - Add actionable test plan with checkboxes for reviewers
   - Link related issues with "Fixes #" or "Related to #"

4. **Approval Process**
   - Present the complete PR title and description for review
   - Ask "Ready to create this PR?" and wait for explicit confirmation
   - Make revisions based on feedback before proceeding
   - Always add `--web` flag to the command to allow reviewer to find the PR in the browser

5. **Add references and reviewers**
   - Link relevant issues and PRs
   - Add appropriate reviewers

## Examples

```bash
# Create PR for current branch
/pr

# Create PR with specific title
/pr "feat: add user authentication system"
```
