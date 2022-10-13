-- ╻ ╻┏━┓┏┓╻╻┏━┓
-- ┃┏┛┗━┓┃┗┫┃┣━┛
-- ┗┛ ┗━┛╹ ╹╹╹
-- Snippet support.

local M = {}

M.init = function(use)
  use({ 'hrsh7th/vim-vsnip', setup = M.setup, after = 'nvim-cmp' })
end

M.setup = function()
  local map = require('utils.keymap').map

  vim.g.vsnip_snippet_dir = vim.fn.expand('$XDG_CONFIG_HOME/nvim/snippets')
  vim.g.vsnip_filetypes = {
    javascript = { 'hooks' },
    javascriptreact = { 'javascript', 'hooks' },
    typescript = { 'javascript', 'hooks' },
    typescriptreact = { 'javascript', 'javascriptreact', 'typescript', 'hooks' },
  }

  map(
    'i',
    '<C-l>',
    'vsnip#available(1) ? \'<Plug>(vsnip-expand-or-jump)\' : \'\'',
    { expr = true, noremap = false, replace_keycodes = false }
  )
  map(
    's',
    '<C-l>',
    'vsnip#available(1) ? \'<Plug>(vsnip-expand-or-jump)\' : \'\'',
    { expr = true, noremap = false, replace_keycodes = false }
  )
end

return M
