
# General writing guidelines

- Always write titles in sentence case.

# Recommended tools

- `exa`: A modern replacement for `ls`.
- `fd`: A command-line tool for finding files and directories.
- `jq`: A command-line tool for processing JSON data.
- `pnpm`: A package manager for Node.js projects.
- `rg`: A command-line tool for searching and replacing text in files.

# Code style guidelines

- Try not to use the `any` type.
  - ✅ `string | number` or specific interface types
  - ❌ `any`
- All code comments should end with a period.
  - ✅ `// Calculate the total sum.`
  - ✅ `/* This function handles user authentication. */`
  - ❌ `// Calculate the total sum`
  - Exception: Single-word labels like `// TODO` or `// FIXME`
- Follow consistent indentation (spaces or tabs, but not mixed).
- Keep functions small and focused on a single responsibility.
- Remove unused imports and variables.
- Use consistent naming conventions throughout the codebase.
- Use meaningful variable and function names.

# Testing guidelines

- Always prefer running tests with `test:ci`.
  - ✅ `pnpm test:ci` or `npm run test:ci`
  - ❌ `pnpm test` or `npm test`
- Ensure all tests pass before submitting PRs.
- Include integration tests for complex features.
- Write unit tests for new functionality.

# Git workflow guidelines

## Pull request guidelines

- Follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) guidelines for PR titles.
- Use past tense when writing descriptions.
- Use the following structure for the body:
  - `### <Name of PR>`
    - Use a clear and concise title for the PR, without using conventional commits.
  - A brief summary of the PR and its purpose (no longer than 200 words). Use sentences rather than lists.
  - #### Key changes
    - A list of the key changes made. Focus on the most important changes rather than listing everything.
  - #### Test plan
    - A checklist of manual tests to perform to verify the PR functionality.

## Commit guidelines

- Follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) guidelines.
- Use imperative mood.
  - ✅ `feat: add user authentication`
  - ✅ `fix: resolve memory leak`
  - ❌ `feat: added user authentication`
  - ❌ `fix: resolved memory leak`
- Limit the first line to 72 characters or less.
- Add concise descriptions only when necessary.

### Examples

```
feat: add user authentication system

chore: update dependencies to latest versions

fix: resolve memory leak in data processing

refactor: simplify user validation logic
```
