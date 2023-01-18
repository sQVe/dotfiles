-- ╺┳┓┏━┓┏━╸┏━┓┏━┓╻┏┓╻┏━╸
--  ┃┃┣┳┛┣╸ ┗━┓┗━┓┃┃┗┫┃╺┓
-- ╺┻┛╹┗╸┗━╸┗━┛┗━┛╹╹ ╹┗━┛
-- Improve default interfaces.

local M = {
  'stevearc/dressing.nvim',
  lazy = true,
}

M.init = function()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    require('lazy').load({ plugins = { 'dressing.nvim' } })
    return vim.ui.select(...)
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(...)
    require('lazy').load({ plugins = { 'dressing.nvim' } })
    return vim.ui.input(...)
  end
end

M.opts = {
  select = { backend = { 'telescope', 'builtin' } },
}

return M
