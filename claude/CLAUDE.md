
# AI assistant guidelines

## Problem-solving approach
- Start by understanding the codebase structure
- Use search tools extensively to gather context
- Plan tasks using TodoWrite when appropriate
- Implement solutions incrementally
- Always verify with tests when available

## Tool usage guidelines

### When to use sequential thinking
- Complex problems requiring multiple steps
- Planning and design tasks
- Analysis that might need course correction
- Breaking down large tasks into smaller components
- Maintaining context across multiple steps

### When to use context7
- Current documentation for libraries/frameworks
- API references and examples
- Up-to-date package information
- Library-specific best practices

### MCP server configuration

#### Available MCP servers
- `mcp__playwright__*`: Browser automation and testing
- `mcp__linear__*`: Linear issue tracking integration
- `mcp__context7__*`: Library documentation lookup
- `mcp__fetch__*`: Web content fetching
- `mcp__sequential-thinking__*`: Complex problem solving
- `mcp__sentry__*`: Error monitoring and issue tracking

#### Usage guidelines
- Use playwright for web testing and automation tasks
- Use linear for issue tracking and project management
- Use context7 for up-to-date library documentation
- Use sentry for error monitoring and debugging production issues
- Prefer MCP fetch over WebFetch when available

## Recommended tools
- `bat`: A modern replacement for `cat` with syntax highlighting
- `delta`: Git diff viewer with better formatting
- `exa`: A modern replacement for `ls`
- `fd`: A command-line tool for finding files and directories
- `fzf`: Fuzzy finder for files and commands
- `jq`: A command-line tool for processing JSON data
- `pnpm`: A package manager for Node.js projects
- `rg`: A command-line tool for searching and replacing text in files

# Code style guidelines

## Type safety
- Do not use the `any` type.
  - ✅ `string | number` or specific interface types
  - ❌ `any`

## Comments
- All code comments should end with a period.
  - ✅ `// Calculate the total sum.`
  - ✅ `/* This function handles user authentication. */`
  - ❌ `// Calculate the total sum`
  - Exception: Single-word labels like `// TODO` or `// FIXME`

## Import organization
- Group imports: external libraries first, then internal modules
- Use absolute imports for clarity when possible
- Sort imports alphabetically within groups
- ✅
  ```typescript
  import { useState } from 'react';
  import { format } from 'date-fns';

  import { userService } from '@/services/user';
  import { formatDate } from '@/utils/date';
  ```

## Error handling
- Prefer explicit error handling over silent failures
- Use Result types or explicit error objects where appropriate
- Include meaningful error messages
- ✅ `throw new Error('User not found with ID: ' + userId)`
- ❌ `throw new Error('Error')`

## Async patterns
- Prefer async/await over Promise chains for readability
- Use Promise.all for concurrent operations
- Handle errors at appropriate levels
- ✅ `const result = await fetchUser(id);`
- ❌ `fetchUser(id).then(result => ...)`

## Naming conventions
- Use meaningful variable and function names
- Keep functions pure and avoid side effects when possible
- Use consistent naming conventions throughout the codebase
- File naming: use kebab-case for files and directories
- Include file type in name where appropriate (e.g., `user.service.ts`, `user.types.ts`)

# Development workflow

## Testing guidelines
- Run tests with `test:ci`.
  - ✅ `pnpm test:ci` or `npm run test:ci`
  - ❌ `pnpm test` or `npm test`
- Write unit tests for new functionality.
- Include integration tests for complex features.

## Git workflow guidelines

### Commit guidelines
- Follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) guidelines.
- Use imperative mood.
  - ✅ `feat: add user authentication`
  - ✅ `fix: resolve memory leak`
  - ❌ `feat: added user authentication`
  - ❌ `fix: resolved memory leak`
- Limit the first line to 72 characters or less.
- Add concise descriptions only when necessary.

#### Examples
```
feat: add user authentication system

chore: update dependencies to latest versions

fix: resolve memory leak in data processing

refactor: simplify user validation logic
```

### Pull request guidelines
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

## General writing guidelines
- Always write titles in sentence case.
