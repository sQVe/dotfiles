---
globs:
  - "**/*_test.go"
---

Group subtests under `TestFunctionName` with `t.Run("descriptive sentence", ...)`.
Name subtests as lowercase verb phrases: "returns error for...", "fails with...".
Call `t.Helper()` on all test helper functions.
Use `t.Parallel()` where tests have no shared state.
Prefer real infrastructure over mocks (real repos, real filesystems).
Use custom assert helpers (`AssertErrorContains`, etc.) over `testify`.
Test setup helpers return values, take `*testing.T` as first arg.
