-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.get_visible_bufnrs = function()
  local bufnrs = {}

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)

    if not bufnrs[bufnr] then
      table.insert(bufnrs, bufnr)
    end
  end

  return bufnrs
end

M.get_symbol_map = function(pad)
  local symbol_map = require('lspkind').symbol_map
  local extended_symbol_map = vim.tbl_extend('force', symbol_map, {
    Array = '',
    Boolean = '',
    Copilot = '',
    Key = '󰌋',
    Module = '',
    Namespace = '',
    Null = '󰟢',
    Number = '',
    Object = '',
    Package = '',
    String = '',
    TypeParameter = '',
  })

  if pad then
    return vim.tbl_map(function(symbol)
      return symbol .. ' '
    end, extended_symbol_map)
  end

  return extended_symbol_map
end

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match('%s')
      == nil
end

return M
