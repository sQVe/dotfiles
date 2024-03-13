-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.try_lint = function()
  local lint = require('lint')

  local names = lint.linters_by_ft[vim.bo.filetype] or {}
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }

  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]

    return linter
      and not (
        type(linter) == 'table'
        and linter.condition
        and not linter.condition(ctx)
      )
  end, names)

  if #names > 0 then
    lint.try_lint(names)
  end
end

return M
