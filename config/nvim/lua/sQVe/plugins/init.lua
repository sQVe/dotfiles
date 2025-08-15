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

  -- Sort by line and delimiter.
  {
    'sQVe/sort.nvim',
    config = true,
    dev = true,
  },

  -- {
  --   'sQVe/monava.nvim',
  --   config = true,
  --   dev = true,
  -- },

  {
    'dmtrKovalenko/fff.nvim',
    build = 'cargo build --release',
    dev = true,
    opts = {
      layout = {
        prompt_position = 'top',
        preview_position = 'bottom',
      },
      preview = {
        enabled = true,
      },
      icons = {
        enabled = false,
      },
    },

    keys = {
      {
        '<leader>ff', -- try it if you didn't it is a banger keybinding for a picker
        function()
          require('fff').find_files()
        end,
        desc = 'Toggle FFF',
      },
    },
  },
}
