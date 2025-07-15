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
   - Title: Conventional format (feat/fix/chore: description).
   - Body: Use this template structure (max 5 items in Summary):
     ```
     Brief summary of what this PR accomplishes, maximum 3 sentences.

     #### Summary
     - First key change made
     - Second key change made
     - Third key change made

     #### Test plan
     - [ ] Specific verification step
     - [ ] Run test suite
     - [ ] Manual testing completed
     ```
   - Use past tense descriptions throughout
   - Create using `gh pr create` command with HEREDOC for body formatting

4. **Get approval**: Always wait for my approval before creating the PR.

Follow CLAUDE.md guidelines for PR title format and content standards.
