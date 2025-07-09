
# AI assistant development guidelines

Universal development guidelines for AI assistant interactions across all projects.

## 🚨 **CRITICAL REQUIREMENTS**

### Development workflow
- **Always run validation**: Run linting, type checking, and tests after ALL code changes.
- **Use TodoWrite tool**: Plan complex tasks and track progress systematically.
- **Understand first**: Analyze codebase structure before making changes.
- **Verify implementation**: Test functionality after changes, follow existing patterns.

### Code quality standards
- **Type safety**: No `any` type, use specific types and interfaces.
- **Error handling**: Explicit errors with meaningful messages, no silent failures.
- **Comments**: End with period (except TODO/FIXME), only when necessary.
- **Testing**: Write unit tests for new functionality, integration tests for complex features.

### Git workflow
- **Commits**: Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format.
- **Format**: `type: description` (feat, fix, chore, docs, refactor, test).
- **Style**: Use imperative mood, limit first line to 72 characters.
- **PRs**: Conventional title, past tense descriptions, include summary/key changes/test plan.

---

## 📋 **PROBLEM-SOLVING APPROACH**

### Analysis methodology
- **Search extensively**: Use available search tools to understand codebase structure.
- **Plan systematically**: Use TodoWrite for complex multi-step tasks.
- **Implement incrementally**: Make small, testable changes and verify each step.
- **Follow conventions**: Mimic existing code style, use established libraries and patterns.

### Research strategy
- **Context7**: For current library docs, API references, best practices.
- **Sequential thinking**: For complex multi-step problems, planning, analysis.
- **MCP servers**: playwright (testing), linear (issues), context7 (docs), fetch (web), sentry (errors).

---

## 🔧 **TECHNICAL GUIDELINES**

### Tool usage
- **Recommended CLI tools**: bat, delta, exa, fd, fzf, jq, pnpm, rg.
- **Search tools**: Use extensively both in parallel and sequentially.
- **Testing commands**: Use `test:ci` command (`pnpm test:ci` or `npm run test:ci`).

### Code organization
- **Imports**: External libraries first, then internal; sort alphabetically.
- **Naming**: Meaningful names, pure functions, kebab-case files.
- **Structure**: Co-located types and tests when possible.

---

## 📝 **CODE STYLE REQUIREMENTS**

### TypeScript standards
- **Functions**: Use proper typing, avoid function overloads unless necessary.
- **Async operations**: Use async/await over Promise chains.
- **Destructuring**: In function signatures, NOT function body.
  - ✅ `function example({ name, age = 18 }: Options) { ... }`
  - ❌ `function example(options: Options) { const { name, age = 18 } = options; ... }`

### Documentation standards
- **Headers**: All markdown headers use sentence case.
- **Lists**: All markdown list items must end with period.
- **Comments**: Must end with period, be concise and meaningful.

---

## 🎯 **DEVELOPMENT WORKFLOW**

### Testing requirements
- **Unit tests**: For new functionality and core logic.
- **Integration tests**: For complex features and external dependencies.
- **Validation**: Always run linting, type checking, and tests before completion.

### Implementation process
1. **Analyze**: Understand existing codebase and requirements.
2. **Plan**: Use TodoWrite for complex tasks.
3. **Implement**: Make incremental changes following existing patterns.
4. **Validate**: Run tests and verification commands.
5. **Review**: Ensure code follows guidelines and conventions.
