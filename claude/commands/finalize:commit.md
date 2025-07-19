# Create atomic git commits with clear messages

<instructions>
  <context>
    Create atomic commits with conventional format and meaningful messages to maintain clean git history. Use concise descriptions only when necessary, focusing on why rather than what.
  </context>

  <requirements>
    - Git repository with staged or unstaged changes
    - Knowledge of conventional commits format
  </requirements>

  <execution>
    1. **Analyze and stage changes**
       - Review `git status` and `git diff` to understand modifications
       - Group related changes into logical, atomic commits
       - Stage appropriate files for each commit

    2. **Craft commit messages**
       - Use conventional commits format: `type: description`
       - Write concise messages focusing on why, not what
       - Add description only when necessary to explain reasoning

    3. **Create commits**
       - Create one commit per logical change
       - Review git history for clean progression
  </execution>

  <validation>
    - [ ] Changes reviewed and understood through git diff analysis
    - [ ] Commit messages follow Conventional Commits specification
    - [ ] Each commit represents one logical, atomic change
    - [ ] Commit messages focus on why, not what (descriptions only when necessary)
    - [ ] Git history shows clean, understandable progression
  </validation>

  <workflow>
    **Prerequisites:** Consider running validation commands before committing:
    - `/validate:code` - Automated linting, formatting, and type checking
    - `/validate:tests` - Test suite execution and coverage analysis
    - `/validate:functionality` - Manual user workflow verification

    **Next steps:** After committing, consider:
    - `/finalize:pr` - Create pull request for code review
    - `/finalize:memory` - Document implementation decisions and context

  </workflow>

  <examples>
    ```bash
    # Basic workflow
    /finalize:commit

    # Process: git status/diff → stage files → create commit
    # Result: "feat: add user password reset via email"
    ```

    ```bash
    # Good commit message examples
    feat: add password reset to improve user recovery options
    fix: resolve timeout issue preventing large file uploads
    refactor: extract validation logic for better testability
    docs: add API examples to reduce integration confusion

    # Avoid (what-focused, vague)
    ❌ "update files"
    ❌ "fix bug"
    ❌ "add password stuff"
    ```

  </examples>
</instructions>
