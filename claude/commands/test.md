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
   Analyze this source code and propose tests that catch real bugs.

   Source code:
   <source>
   {file_content}
   </source>

   Framework: {detected_framework}
   Existing test patterns: {existing_test_examples}

   ## Step 1: Identify testable logic

   Find code that makes DECISIONS or TRANSFORMATIONS:
   - Conditionals (if/else, switch, ternary, ??, ||)
   - Data transformations (map, reduce, string manipulation, calculations)
   - Default values and fallbacks
   - Error handling branches (try/catch, .catch, error returns)
   - Validation logic
   - State machines or multi-step processes

   ## Step 2: Exclude non-logic

   Do NOT propose tests for:
   - Passthrough: value goes in, same value comes out unchanged
   - Wiring: "calls X with Y" where X is mocked (test the real X instead)
   - Content existence: "contains this string" without conditional logic
   - Type coercion handled by the language/framework

   ## Step 3: Propose tests for identified logic

   For each piece of logic found, propose tests that verify:
   - Each branch of conditionals executes correctly
   - Transformations produce expected output
   - Edge cases WHERE THE CODE HAS HANDLING (not generic edge cases)
   - Error paths trigger and recover properly

   Output as JSON:
   {
     "proposals": [{
       "function": "name",
       "logic_found": "brief description of the decision/transformation",
       "test_cases": [{"scenario": "when X", "expected": "then Y"}],
       "mocks_needed": ["..."]
     }]
   }

   If a function has no testable logic (pure passthrough, simple wiring), return empty proposals for it.

   <success_criteria>
   - [ ] Identified specific logic (conditionals, transformations) in code
   - [ ] Each proposal tied to actual code logic, not generic edge cases
   - [ ] No passthrough or wiring-only tests proposed
   - [ ] Returned valid JSON matching schema
   </success_criteria>
   ```

6. **Merge by consensus**
   - Group by `function` + `logic_found`, count votes (1–3)
   - Merge test_cases and mocks; sort by vote count
   - Discard proposals where `logic_found` is vague or describes passthrough

7. **Confirm test plan** (OUTPUT GATE)
   - Output proposed tests grouped by file as formatted text
   - Include: function, logic being tested, test scenarios
   - End output with `---` separator
   - **PROHIBITED after separator:**
     - "Let me...", "I'll...", "Now I will..."
     - "Starting with...", "First I'll..."
     - Any action-announcing language
   - IMMEDIATELY use `AskUserQuestion` with options:
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

<anti_patterns>
After presenting findings, NEVER:
- "Let me create/start/begin..."
- "I'll now..."
- "Starting with the first..."
- "Now I will..."
- Announcing intent before user chooses action
</anti_patterns>
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
| Function | Logic Tested | Scenarios |
|----------|--------------|-----------|
| parse    | MSO comment fix, concurrent render | 4 |
| validate | fallback defaults, pluralization | 3 |
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
