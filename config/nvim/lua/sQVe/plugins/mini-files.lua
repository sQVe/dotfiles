-- ┏┳┓╻┏┓╻╻   ┏━╸╻╻  ┏━╸┏━┓
-- ┃┃┃┃┃┗┫┃   ┣╸ ┃┃  ┣╸ ┗━┓
-- ╹ ╹╹╹ ╹╹   ╹  ╹┗━╸┗━╸┗━┛
-- File tree.

local M = {
  'echasnovski/mini.files',
}

M.opts = {
  mappings = {
    go_in = '',
    go_in_plus = '<CR>',
    go_out = '',
    go_out_plus = '<BS>',
    reset = '',
  },
  windows = {
    max_number = 3,
    preview = true,
    width_focus = 40,
    width_nofocus = 20,
    width_preview = 80,
  },
}

M.config = function(_, opts)
  local mini_files = require('mini.files')

  local augroup = require('sQVe.utils.vim').augroup
  local autocmd = require('sQVe.utils.vim').autocmd
  local map = require('sQVe.utils.vim').map

  mini_files.setup(opts)

  map('n', 'Å', function()
    if not mini_files.close() then
      mini_files.open(vim.api.nvim_buf_get_name(0), false)
    end
  end, { desc = 'Open file tree' })

  autocmd('User', {
    group = augroup('MiniFilesBufferCreate'),
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id

      vim.keymap.set('n', '<Esc>', mini_files.close, { buffer = buf_id })
      vim.keymap.set('n', '<S-Backspace>', function()
        mini_files.open(nil, false)
      end, { buffer = buf_id })
      vim.keymap.set('n', '<Tab>', '', { buffer = buf_id })
      vim.keymap.set('n', '<S-Tab>', '', { buffer = buf_id })
    end,
  })
end

return M
