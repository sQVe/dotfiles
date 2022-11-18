-- ╺┳┓╻┏━╸┏━╸╻ ╻╻┏━╸╻ ╻
--  ┃┃┃┣╸ ┣╸ ┃┏┛┃┣╸ ┃╻┃
-- ╺┻┛╹╹  ╹  ┗┛ ╹┗━╸┗┻┛
-- Improved diff mode interface.

local M = {}

M.init = function(use)
  use({
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    config = M.config,
    setup = M.setup,
    requires = 'nvim-lua/plenary.nvim',
  })
end

M.config = function()
  require('diffview').setup({
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
  })
end

M.setup = function()
  local map = require('sQVe.utils.vim').map

  map('n', '<Leader>gd', '<Cmd>DiffviewOpen<CR>')
  map('n', '<Leader>gl', '<Cmd>DiffviewFileHistory<CR>')
  map('n', '<Leader>gL', '<Cmd>DiffviewFileHistory %<CR>')
end

return M
