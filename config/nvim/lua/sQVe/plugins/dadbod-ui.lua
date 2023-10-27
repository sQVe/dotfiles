-- ╺┳┓┏━┓╺┳┓┏┓ ┏━┓╺┳┓   ╻ ╻╻
--  ┃┃┣━┫ ┃┃┣┻┓┃ ┃ ┃┃   ┃ ┃┃
-- ╺┻┛╹ ╹╺┻┛┗━┛┗━┛╺┻┛   ┗━┛╹
-- Simple database UI.

local M = {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', cmd = { 'DB' } },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql' },
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
}

M.init = function()
  vim.g.db_ui_use_nerd_fonts = 1
end

M.config = function()
  vim.cmd([[
    autocmd FileType sql,mysql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  ]])
end

return M
