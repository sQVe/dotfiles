---
name: test
description: Generate behavior-focused tests via parallel analysis
argument-hint: '[scope] [--framework=<name>]'
model: claude-opus-4-5-20251101
allowed-tools:
  - Read
  - Bash
  - Glob
  - Grep
  - Task
  - Write
  - Edit
---

<objective>
Generate behavior-focused tests using parallel subagent analysis and consensus voting.
</objective>

<arguments>
- `scope`: One of:
  - `unstaged` (default): Test unstaged changes
  - `staged`: Test staged changes
  - `branch`: Test changes since divergence from main
  - `<path>`: Test specific file or directory
- `--framework=<name>`: Override auto-detected framework
</arguments>

<process>

1. **Validate prerequisites**
   - Run `git rev-parse --git-dir` — if fails and scope is git-based: "Not a git repository"
   - Parse scope argument per `<arguments>`
   - If no files found matching scope: "No source files found for scope: {scope}"
   - If validation fails: stop with clear message

2. **Gather source code**

   ```bash
   # For unstaged (default)
   git diff --name-only | grep -E '\.(ts|tsx|js|jsx|py|go|rs)$'

   # For staged
   git diff --cached --name-only | grep -E '\.(ts|tsx|js|jsx|py|go|rs)$'

   # For branch (detect default branch dynamically)
   # Fallback chain: origin/HEAD -> main -> master
   MAIN_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git rev-parse --verify main 2>/dev/null && echo main || echo master)
   git diff $(git merge-base HEAD $MAIN_BRANCH)..HEAD --name-only | grep -E '\.(ts|tsx|js|jsx|py|go|rs)$'

   # For path
   # Use provided path directly
   ```

3. **Detect framework**

   Check in order:
   - Existing test files (patterns: `*.test.*`, `*.spec.*`, `*_test.*`, `test_*.*`)
   - Config files: `jest.config.*`, `vitest.config.*`, `pytest.ini`, `pyproject.toml`, `go.mod`, `Cargo.toml`
   - Package.json scripts containing test commands

   `--framework` overrides auto-detection.

   If no framework detected and no `--framework` flag, prompt user to specify framework or abort with error listing detected project files.

4. **Collect existing test examples**

   Find 1-2 existing test files matching detected framework patterns. Read and extract:
   - Import style and assertion library
   - Test organization (describe/it vs flat test())
   - Naming conventions
   - Setup/teardown patterns

   If no existing tests, use framework defaults.

5. **Dispatch 3 subagents in parallel**

   Output before spawning: "Analyzing {N} files with 3 parallel agents..."

   Each subagent analyzes all source files together (not split). Use Task tool with `subagent_type: "general-purpose"` and `model: "sonnet"`.

   **Subagent prompt:**

   ```
   Analyze this source code and propose valuable tests.

   Source code:
   <source>
   {file_content}
   </source>

   Framework: {detected_framework}
   Existing test patterns: {existing_test_examples}

   Propose tests that catch real bugs. Focus on:
   - Public API behavior
   - Edge cases:
     - Empty/null/undefined inputs
     - Boundary values (0, -1, max, min)
     - Invalid types (string where number expected)
     - Async: timeouts, cancellation, race conditions
     - Large inputs (performance, memory)
     - Unicode, encoding, and special characters
     - Date/time: timezones, DST, leap years, epoch
     - Localization: locale-specific formatting, RTL text
     - Error conditions and recovery
   - Integration points requiring mocks

   Output as JSON:
   {"proposals": [{"function": "name", "behavior": "what it does", "edge_cases": ["..."], "mocks_needed": ["..."]}]}

   Test behavior, not implementation.

   <success_criteria>
   - [ ] Analyzed all source files in scope
   - [ ] Proposed tests for public APIs
   - [ ] Identified edge cases from code inspection
   - [ ] Returned valid JSON matching schema
   - [ ] Each proposal has concrete test scenario
   </success_criteria>
   ```

6. **Merge by consensus**
   - Group by `function` + `behavior`, count votes (1–3)
   - Dedupe edge cases and mocks; sort by vote count

7. **Confirm test plan**
   - Output proposed tests grouped by file as formatted text
   - Include: function, behavior, edge cases covered
   - Use `AskUserQuestion` with options:
     - **Generate all** — create all proposed tests
     - **Select tests** — choose which tests to generate
     - **Add more** — request additional test cases
     - **Cancel** — abort without generating

8. **Generate tests**

   For each proposal with consensus ≥ 2 (or all proposals if total < 5):
   - **Determine test file location** (in priority order)
     - Add to existing test file for the same source if one exists
     - Use `__tests__/` directory if project has one
     - Use `tests/` directory if project has one (but not `__tests__/`)
     - Otherwise colocate as `{source}.test.{ext}`

   - **Generate tests following conventions**
     - Match existing test style (describe blocks, naming, assertions)
     - Include setup/teardown if pattern exists
     - Mock external dependencies identified in analysis
     - One test per behavior, clear assertion messages

   - **Write test files**
     - Group related tests. Use Write or Edit.

9. **Run generated tests**

   ```bash
   # Framework-specific commands
   # Jest/Vitest: npx jest {test_file} / npx vitest run {test_file}
   # Pytest: pytest {test_file}
   # Go: go test {package}
   # Rust: cargo test {module}
   ```

10. **Fix loop (max 3 iterations)**

    If tests fail:
    - Analyze failure, fix, re-run
    - Repeat until passing or iteration limit reached
    - Report remaining issues at limit

</process>

<output_format>

```
## Test generation summary

**Scope:** {scope_description}
**Framework:** {detected_framework}
**Consensus:** {n} proposals from 3 subagents

### Generated files
- `path/to/file.test.ts` (5 tests)
- `path/to/other.test.ts` (3 tests)

### Verification
✓ All 8 tests passing

### Coverage
| Function | Behaviors Tested | Edge Cases |
|----------|------------------|------------|
| parse    | 2                | 3          |
| validate | 1                | 2          |
```

---

## ▶ Next Up

**Run full test suite** — verify no regressions

`npm test` — run all tests

---

**Also available:**

- `/commit` — commit generated tests
- `/review` — review test quality

---

</output_format>

<success_criteria>

- [ ] Dispatch 3 subagents with identical prompts
- [ ] Merge proposals by consensus
- [ ] User confirmed test plan
- [ ] Tests generated
- [ ] Verify tests pass
- [ ] Report summary
      </success_criteria>
