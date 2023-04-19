-- ╺┳┓╻┏━╸┏━╸╻ ╻╻┏━╸╻ ╻
--  ┃┃┃┣╸ ┣╸ ┃┏┛┃┣╸ ┃╻┃
-- ╺┻┛╹╹  ╹  ┗┛ ╹┗━╸┗┻┛
-- Improved diff mode interface.

local M = {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<Leader>gd', '<Cmd>DiffviewOpen<CR>', desc = 'Open diffview' },
    {
      '<Leader>gh',
      '<Cmd>DiffviewFileHistory<CR>',
      desc = 'File history',
    },
    {
      '<Leader>gH',
      '<Cmd>DiffviewFileHistory %<CR>',
      desc = 'File history for buffer',
    },
  },
}

M.opts = {
  hooks = {
    diff_buf_win_enter = function()
      -- Turn off line wrapping, list chars, and relative numbers.
      vim.opt_local.wrap = false
      vim.opt_local.list = false
      vim.opt_local.relativenumber = false

      -- Disable indentation guides.
      require('indent_blankline.commands').disable()
    end,
  },
}

return M
