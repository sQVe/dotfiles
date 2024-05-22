-- ┏━┓╻  ╻ ╻┏━╸╻┏┓╻┏━┓
-- ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫┗━┓
-- ╹  ┗━╸┗━┛┗━┛╹╹ ╹┗━┛

return {
  -- Dependencies.
  { 'MunifTanjim/nui.nvim', lazy = true }, -- UI component library.
  { 'SmiteshP/nvim-navic', lazy = true }, -- Show current code context.
  { 'nvim-lua/plenary.nvim', lazy = true }, -- Lua utilities.
  { 'nvim-tree/nvim-web-devicons', lazy = true }, -- File icons.
  { 'onsails/lspkind-nvim', lazy = true }, -- LSP kind icons.
  { 'tpope/vim-repeat', event = 'VeryLazy' }, -- Repeat support for plugins.

  -- Unlist hidden buffers that are git ignored.
  {
    'sQVe/bufignore.nvim',
    config = true,
    event = { 'BufRead', 'BufWrite' },
  },

  -- Auto close pairs.
  { 'echasnovski/mini.pairs', config = true, event = 'VeryLazy' },

  -- Simple session management.
  { 'folke/persistence.nvim', config = true, event = 'BufRead' },

  -- Set commentstring.
  { 'folke/ts-comments.nvim', config = true, event = 'VeryLazy' },

  -- Markdown preview.
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
