-- ┏━┓╻┏━╸╻┏ ┏━╸┏━┓
-- ┣━┛┃┃  ┣┻┓┣╸ ┣┳┛
-- ╹  ╹┗━╸╹ ╹┗━╸╹┗╸
-- Fuzzy finders.

local autocmd = require('sQVe.utils.autocmd')
local buffer = require('sQVe.utils.buffer')
local path = require('sQVe.utils.path')

local BIG_FILE_THRESHOLD = 1 * 1024 * 1024 -- 1 MiB.

local buf_dir = ''

local update_buf_dir = function()
  local bufnr = buffer.get_bufnr()
  local winid = vim.api.nvim_get_current_win()

  local win_config = vim.api.nvim_win_get_config(winid)
  local is_floating = win_config.relative ~= ''

  if not is_floating and buffer.is_valid(bufnr) and buffer.is_saved(bufnr) then
    buf_dir = path.get_parent(buffer.get_path(bufnr))
  end
end

autocmd({ 'BufAdd', 'BufEnter', 'WinEnter', 'BufWritePost' }, {
  group = 'SnacksUpdateCurrentBufDir',
  callback = update_buf_dir,
})

return {
  formatters = {
    file = { truncate = 60 },
  },
  previews = {
    file = {
      max_size = BIG_FILE_THRESHOLD,
    },
  },
  sources = {
    buf_files = {
      matcher = {
        sort_empty = true,
      },
      multi = {
        { source = 'buffers', format = 'file', current = false },
        'files',
      },
      sort = function(a, b)
        if
          vim.startswith(a._path, buf_dir)
          ~= vim.startswith(b._path, buf_dir)
        then
          return vim.startswith(a._path, buf_dir)
        end

        return Snacks.picker.sort.default()(a, b)
      end,
      title = 'Buffers and files',
      transform = 'unique_file',
    },
  },
  win = {
    input = {
      keys = {
        ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
      },
    },
  },
}
