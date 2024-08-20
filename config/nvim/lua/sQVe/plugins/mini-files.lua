-- ┏┳┓╻┏┓╻╻   ┏━╸╻╻  ┏━╸┏━┓
-- ┃┃┃┃┃┗┫┃   ┣╸ ┃┃  ┣╸ ┗━┓
-- ╹ ╹╹╹ ╹╹   ╹  ╹┗━╸┗━╸┗━┛
-- File tree.

local autocmd = require('sQVe.utils.autocmd')
local buffer = require('sQVe.utils.buffer')
local map = require('sQVe.utils.map')

local M = {
  'echasnovski/mini.files',
}

M.opts = {
  mappings = {
    go_in = '',
    go_in_plus = 'l',
    go_out = '',
    go_out_plus = 'h',
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

  mini_files.setup(opts)

  map('n', 'Ä', function()
    local bufnr = buffer.get_bufnr()

    if not mini_files.close() then
      mini_files.open(
        buffer.is_valid(bufnr) and buffer.get_path(bufnr) or nil,
        false
      )
    end
  end, { desc = 'Open file tree' })

  autocmd('User', {
    group = 'MiniFilesBufferCreate',
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id

      map('n', '<CR>', function()
        for _ = 1, vim.v.count1 do
          mini_files.go_in({ close_on_file = true })
        end
      end, { buffer = buf_id })
      map('n', '<Esc>', mini_files.close, { buffer = buf_id })
      map('n', '<Tab>', '', { buffer = buf_id })
      map('n', '<S-Tab>', '', { buffer = buf_id })
    end,
  })
end

return M
