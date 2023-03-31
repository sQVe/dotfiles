-- ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
-- ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
-- ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

-- Add builtin plugins.
vim.cmd('packadd cfilter')

return {
  -- Dependencies.
  { 'MunifTanjim/nui.nvim', lazy = true }, -- UI component library.
  { 'SmiteshP/nvim-navic', lazy = true }, -- Show current code context.
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Lua utilities.
  { 'nvim-tree/nvim-web-devicons', lazy = true }, -- File icons.
  { 'onsails/lspkind-nvim', lazy = true }, -- LSP kind icons.
  { 'tpope/vim-repeat', event = 'VeryLazy' }, -- Repeat support for plugins.

  -- Editorconfig.
  { 'gpanders/editorconfig.nvim', event = { 'BufNew', 'BufRead' } },

  -- Textobjects.
  { 'michaeljsmith/vim-indent-object', event = 'VeryLazy' }, -- Indent textobject.
  { 'echasnovski/mini.ai', event = 'VeryLazy' }, -- Additional textobjects.
}
