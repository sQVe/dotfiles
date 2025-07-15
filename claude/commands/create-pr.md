Create a pull request following these steps:

1. **Pre-PR validation**: Ensure all commits are ready and branch is current.
   - Verify commits follow Conventional Commits format.
   - Check branch is up to date with base branch.
   - Push branch to remote if needed (`git push -u origin <branch>`).

2. **Analyze PR scope**: Review all changes included in the PR.
   - Run `git log [base-branch]...HEAD` to see commit history.
   - Run `git diff [base-branch]...HEAD` to see full changeset.
   - Understand the complete scope of changes.

3. **Create PR**: Use proper format and structure.
   - Title: Conventional commit format (feat/fix/chore: description).
   - Body: Use this template structure (max 5 items in Summary):

     ```markdown
     Brief description of what this PR does and why.

     #### Changes

     - List of key changes
     - What was added, modified, or removed

     #### Testing

     - [ ] Tests added/updated
     - [ ] All tests pass
     - [ ] Manual testing completed

     Fixes #123
     Related to #456
     ```

   - Use past tense descriptions throughout
   - Create using `gh pr create` command with HEREDOC for body formatting

4. **Get approval**: Always wait for my approval before creating the PR.

Follow CLAUDE.md guidelines for PR title format and content standards.
