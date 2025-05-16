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
    go_in_plus = '<Right>',
    go_out = '',
    go_out_plus = '<Left>',
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

  local go_in_plus = function()
    for _ = 1, vim.v.count1 do
      mini_files.go_in({ close_on_file = true })
    end
  end

  local go_out_plus = function()
    for _ = 1, vim.v.count1 do
      mini_files.go_out()
    end
  end

  map('n', 'Ä', function()
    local bufnr = buffer.get_bufnr()

    if not mini_files.close() then
      mini_files.open(
        buffer.is_valid(bufnr) and buffer.get_path(bufnr) or nil,
        false
      )
    end
  end, { desc = 'Open file tree' })

  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. ' split')
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
      go_in_plus()
    end

    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end

  autocmd('User', {
    group = 'MiniFilesBufferCreate',
    pattern = 'MiniFilesBufferCreate',
    callback = function(event)
      local buf_id = event.data.buf_id

      map('n', '<CR>', go_in_plus, { buffer = buf_id })
      map('n', '<Backspace>', go_out_plus, { buffer = buf_id })

      map('n', '<Esc>', mini_files.close, { buffer = buf_id })
      map('n', '<Tab>', '', { buffer = buf_id })
      map('n', '<S-Tab>', '', { buffer = buf_id })
    end,
  })

  autocmd('User', {
    pattern = 'MiniFilesActionRename',
    callback = function(event)
      Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
  })

  autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id

      map_split(buf_id, '<C-s>', 'belowright horizontal')
      map_split(buf_id, '<C-v>', 'belowright vertical')
    end,
  })
end

return M
