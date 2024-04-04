-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.try_lint = function()
  local lint = require('lint')
  local linters = require('sQVe.plugins.nvim-lint.linters').by_ft[vim.bo.filetype]
    or {}

  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')

  linters = vim.tbl_filter(function(linter_name)
    local linter = lint.linters[linter_name]

    return linter
      and not (
        type(linter) == 'table'
        and linter.condition
        and not linter.condition(ctx)
      )
  end, linters)

  if #linters > 0 then
    lint.try_lint(linters)
  end
end

return M
