-- ┏┳┓╻┏┓╻╻   ┏━╸╻╻  ┏━╸┏━┓
-- ┃┃┃┃┃┗┫┃   ┣╸ ┃┃  ┣╸ ┗━┓
-- ╹ ╹╹╹ ╹╹   ╹  ╹┗━╸┗━╸┗━┛
-- File tree.

local M = {
  'echasnovski/mini.files',
  version = '*',
}

M.opts = {}

M.config = function(_, opts)
  local mini_files = require('mini.files')
  local map = require('sQVe.utils.vim').map

  mini_files.setup(opts)

  map('n', '-', function()
    mini_files.open()
  end, { desc = 'Open file tree' })
  map('n', '_', function()
    mini_files.open(vim.api.nvim_buf_get_name(0), false)
  end, { desc = 'Open file tree at current file' })
end

return M
