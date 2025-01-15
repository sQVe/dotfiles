-- ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
-- ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
-- ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

return {
  -- Dependencies.
  { 'MunifTanjim/nui.nvim', lazy = true }, -- UI component library.
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Lua utilities.
  { 'tpope/vim-repeat', event = 'VeryLazy' }, -- Repeat support for plugins.

  -- Simple session management.
  { 'folke/persistence.nvim', config = true, event = 'BufRead' },

  -- Set commentstring.
  { 'folke/ts-comments.nvim', config = true, event = 'VeryLazy' },

  -- Unlist hidden buffers that are git ignored.
  {
    'sQVe/bufignore.nvim',
    config = true,
    event = { 'BufRead', 'BufWrite' },
  },
}
