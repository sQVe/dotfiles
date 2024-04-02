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
    preview = true,
    width_focus = 40,
    width_preview = 40,
    width_nofocus = 20,
  },
}

M.config = function(_, opts)
  local mini_files = require('mini.files')

  local augroup = require('sQVe.utils.vim').augroup
  local autocmd = require('sQVe.utils.vim').autocmd
  local map = require('sQVe.utils.vim').map

  local toggle = function(...)
    if not mini_files.close() then
      mini_files.open(...)
    end
  end

  mini_files.setup(opts)

  -- map('n', '<Leader>f', function()
  --   toggle()
  -- end, { desc = 'Open file tree' })
  -- map('n', '<Leader>F', function()
  --   toggle(vim.api.nvim_buf_get_name(0), false)
  -- end, { desc = 'Open file tree at current file' })

  autocmd('User', {
    group = augroup('MiniFilesBufferCreate'),
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id

      vim.keymap.set('n', '<Esc>', mini_files.close, { buffer = buf_id })
    end,
  })
end

return M
