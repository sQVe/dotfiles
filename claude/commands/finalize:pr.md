# Create pull request with clear description and test plan

<instructions>
  <context>
    Create a well-structured pull request with clear description and proper formatting to facilitate effective code review.
  </context>

  <requirements>
    - Branch with completed work
    - Git repository with remote access configured
    - GitHub CLI (gh) installed and authenticated
    - Base branch accessible for comparison
  </requirements>

  <execution>
    1. **Analyze changes**
       - Review commit history with `git log [base-branch]...HEAD`
       - Examine full changeset with `git diff [base-branch]...HEAD`
       - Understand scope and impact of modifications

    2. **Prepare PR content**
       - Craft title using conventional commits format
       - Write clear description focusing on what and why
       - Include testing approach and related issue references

    3. **Create pull request**
       - Use `gh pr create` with structured formatting
       - Push branch to remote if needed
       - Verify successful creation and provide PR URL
  </execution>

  <validation>
    - [ ] Changes analyzed and scope understood
    - [ ] PR title follows conventional commits format
    - [ ] PR description is clear and well-structured
    - [ ] Related issues and testing approach included
    - [ ] Pull request created successfully with proper formatting
  </validation>

  <workflow>
    **Prerequisites:** Ensure code quality before creating PR:
    - `/validate:code` - Run automated quality checks
    - `/validate:tests` - Verify test coverage and passing tests
    - `/finalize:commit` - Create clean, atomic commits

    **Related commands:**
    - `/validate:quality` - Additional code quality analysis
    - `/finalize:memory` - Document decisions for future reference
  </workflow>

  <examples>
    ```bash
    # Standard PR creation
    /finalize:pr

    # Process: analyze changes → prepare content → create PR
    # Result: Well-structured PR with conventional title and clear description
    ```

    ```bash
    # Example PR creation with template
    gh pr create --title "feat: add user authentication" --body "$(cat <<'EOF'
    Added JWT-based authentication system for secure user access.

    #### Changes
    - Implemented JWT token generation and validation
    - Added login/logout endpoints with session management
    - Created authentication middleware for protected routes

    #### Test plan
    - [ ] Navigate to /login and verify login form renders correctly
    - [ ] Test login with valid credentials - should redirect to dashboard
    - [ ] Test login with invalid credentials - should show error message
    - [ ] Verify protected routes redirect to login when not authenticated
    - [ ] Test logout functionality clears session and redirects to login
    - [ ] Check that JWT tokens expire after configured time

    Fixes #123
    Related to #456
    EOF
    )"
    ```
  </examples>
</instructions>
