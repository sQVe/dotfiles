---
globs:
  - '**/*_spec.lua'
---

`_spec.lua` suffix for test files.
Separate `tests/` directory mirroring source layout.
`describe`/`it` blocks (busted). Outer `describe` names the module; inner groups by function or behavior.
Test descriptions as present-tense behavioral sentences.
luassert assertions: `assert.are.equal`, `assert.are.same`, `assert.is_nil`, `assert.is_true`.
`before_each`/`after_each` for setup and teardown.
Manual mocking: save originals, replace in `before_each`, restore in `after_each`.
`package.loaded['module'] = nil` to reset module state between tests.
`vim.wait` for async assertions.
