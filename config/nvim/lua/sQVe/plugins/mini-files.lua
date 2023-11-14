-- ┏┳┓╻┏┓╻╻   ┏━╸╻╻  ┏━╸┏━┓
-- ┃┃┃┃┃┗┫┃   ┣╸ ┃┃  ┣╸ ┗━┓
-- ╹ ╹╹╹ ╹╹   ╹  ╹┗━╸┗━╸┗━┛
-- File tree.

local M = {
  'echasnovski/mini.files',
  version = '*',
}

M.opts = {
  mappings = {
    go_in = '',
    go_in_plus = '',
    go_out = '',
    go_out_plus = '',
  },
}

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

  local go_in_plus = function()
    for _ = 1, vim.v.count1 - 1 do
      mini_files.go_in()
    end

    local fs_entry = mini_files.get_fs_entry()
    local is_at_file = fs_entry ~= nil and fs_entry.fs_type == 'file'

    mini_files.go_in()
    if is_at_file then
      mini_files.close()
    end
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      map('n', 'l', go_in_plus, { buffer = args.data.buf_id })
      map('n', '<CR>', go_in_plus, { buffer = args.data.buf_id })
      map('n', '<Right>', go_in_plus, { buffer = args.data.buf_id })

      map('n', 'h', mini_files.go_out, { buffer = args.data.buf_id })
      map('n', '<Left>', mini_files.go_out, { buffer = args.data.buf_id })
    end,
  })
end

return M
