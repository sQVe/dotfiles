---
globs:
  - "**/*.lua"
---

Format with stylua; per-project `.stylua.toml` sets `column_width`.
`snake_case` for all identifiers; `_` prefix for unused parameters.
Module pattern: `local M = {}`, functions on `M`, `return M`.
`local function` for private helpers; `function M.name()` for public API.
Everything `local`. No globals.
LuaCATS type annotations (`---@param`, `---@return`, `---@class`) on public functions.
`pcall` for fallible operations.
Explicit nil checks (`not value` or `value == nil`), not truthiness.
`vim.notify` with `vim.log.levels.*` for user-facing messages.
