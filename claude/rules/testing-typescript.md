---
globs:
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.integration.test.ts"
---

Co-locate test files with source.
Use `.integration.test.ts` suffix for tests that need real infrastructure.
Nest `describe` blocks: unit under test > method/behavior > individual cases.
Name tests as descriptive sentences: "should [verb]" or verb phrase.
Use `vi.spyOn` for partial mocking; `vi.fn()` for manual mock objects.
Structure as arrange/act/assert with blank line separation.
