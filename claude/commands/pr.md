# PR Command

Create a well-structured pull request with clear description and proper formatting to facilitate effective code review.

## Usage
```
/pr [pr-title]
```

## Instructions
You are helping create a comprehensive pull request. Follow these steps:

1. **Prepare branch** by verifying all changes are committed, pushed, and tests pass

2. **Create PR description** using the template format from `claude/templates/pr-template.md`:
   - Use conventional commit format for title (feat:, fix:, docs:, etc.)
   - Include Changes section with technical implementation details
   - Add Test plan section with actionable checkboxes
   - Link related issues with "Fixes #" or "Related to #"

3. **Add references and reviewers** linking issues and tagging appropriate team members

## Examples
```bash
# Create PR for current branch
/pr

# Create PR with specific title
/pr "feat: add user authentication system"
```
