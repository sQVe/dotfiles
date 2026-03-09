---
globs:
  - '**/*.go'
---

Single lowercase word for package names.
Single-letter receivers derived from type name.
`New` prefix for constructors; `Is` prefix for predicates.
Sentinel errors with `errors.New` at package scope; `Err` prefix.
Wrap errors with `fmt.Errorf("context: %w", err)`.
Validate inputs at the top of public functions.
Godoc comments on all exported symbols; function name as first word.
Use `internal/` over `pkg/`.
Always `defer cancel()` after `context.WithTimeout` or `context.WithCancel`.
`_ =` for intentionally discarded errors.
