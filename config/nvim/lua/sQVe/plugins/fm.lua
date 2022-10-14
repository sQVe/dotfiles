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
      { 'n', 'Ä' },
      { 'n', 'Å' },
    },
  })
end

M.config = function()
  local map = require('sQVe.utils.keymap').map

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

  -- Open Vifm in PWD.
  map('n', 'Ä', '<Cmd>Vifm<CR>')

  -- Open Vifm relative to current buffer.
  map('n', 'Å', '<Cmd>Vifm %:p:h<CR>')
end

return M
