---
globs:
  - "**/*.ts"
  - "**/*.tsx"
---

Infer types; omit return types when inferable (Math.*, literals, simple expressions).
Use `??` for defaults, `||` only for intentional falsy checks.
Use `if (value != null)` for null checks.
Use `null` over `undefined` for intentional absence.
Use `unknown` instead of `any`.
Use arrow functions; reserve `function` for generators and overloads.
Use braces for all control flow statements.
Use explicit checks instead of `!` assertions.
Use `import type` for type-only imports; inline `type` keyword when mixing values and types.
Use `interface` for object shapes; `type` for unions, intersections, and inferences.
PascalCase files for React components; camelCase files for utilities and hooks.
Underscore prefix for private class fields (`_database`, `_service`).
`null` in domain models (`.nullable()`); `undefined` for optional params (`.optional()`).
