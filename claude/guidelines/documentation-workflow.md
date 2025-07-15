# Documentation workflow

*Creating and maintaining clear, useful documentation*

### When to document

- **New public APIs** - Document parameters, return values, examples
- **Complex logic** - Explain why decisions were made
- **Configuration changes** - Update setup and usage instructions
- **Breaking changes** - Clear migration guidance
- **Bug fixes** - Document root cause if non-obvious

### Core principles

- **Write for your audience** - Developers need different info than users
- **Explain why, not what** - Code shows what, docs explain reasoning
- **Keep it current** - Update docs in the same PR as code changes
- **Test examples** - Verify code snippets actually work
- **Stay concise** - Remove outdated content regularly

### Essential documentation types

- **Inline comments** - Complex business logic and edge cases, explain why decisions were made
- **README** - Setup, basic usage, contribution guidelines
- **API docs** - Endpoints, parameters, response formats, usage examples
- **Architecture notes** - Key design decisions and trade-offs, explain why you chose one approach over alternatives

### Style guidelines

- **Use clear, simple language** - Avoid jargon when simpler words work
- **Be consistent with formatting** - Use the same heading styles, code block formatting, and list structures throughout
- **End code comments with a period** - All code comments should be complete sentences ending with proper punctuation
- **Use proper punctuation in lists** - End list items with periods when they are complete sentences or phrases

### Maintenance

- Update documentation with code changes
- Remove or mark deprecated information
