-- ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
-- ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
-- ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

-- Add builtin plugins.
vim.cmd('packadd cfilter')

return {
  -- Dependencies.
  { 'MunifTanjim/nui.nvim', lazy = true }, -- UI component library.
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Lua utilities.
  { 'nvim-tree/nvim-web-devicons', lazy = true }, -- File icons.
  { 'tpope/vim-repeat', event = 'VeryLazy' }, -- Repeat support for plugins.

  -- Editorconfig.
  { 'gpanders/editorconfig.nvim', event = 'BufReadPre' },

  -- Text objects.
  { 'michaeljsmith/vim-indent-object', event = 'VeryLazy' }, -- Indent text object.
  { 'wellle/targets.vim', event = 'VeryLazy' }, -- Additional text objects.
}
