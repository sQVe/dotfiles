-- ┏━╸┏┳┓
-- ┣╸ ┃┃┃
-- ╹  ╹ ╹
-- Vifm.

local M = {}

M.init = function(use)
  use({
    'is0n/fm-nvim',
    cmd = { 'Vifm' },
    config = M.config,
    keys = {
      { 'n', 'Ä' }, { 'n', 'Å' } },
  })
end

M.config = function()
  require('fm-nvim').setup({
    ui = {
      float = {
        border = 'rounded',
      },
    },
    mappings = {
      edit = '<C-e>',
      horz_split = '<C-s>',
      vert_split = '<C-v>',
      tabedit = '<C-t>',
      ESC = '<ESC>',
    },
  })

  vim.cmd([[
    nnoremap <silent> Ä <Cmd>Vifm<CR>
    nnoremap <silent> Å <Cmd>Vifm %:p:h<CR>
  ]])
end

return M
