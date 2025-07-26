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
  local is_floating = win_config.relative ~= '' or win_config.external

  if not is_floating and buffer.is_valid(bufnr) then
    local buf_path = buffer.get_path(bufnr)
    if buf_path and buf_path ~= '' then
      local parent_dir = path.get_parent(buf_path)
      if
        parent_dir
        and parent_dir ~= ''
        and vim.fn.isdirectory(parent_dir) == 1
      then
        buf_dir = parent_dir
      end
    end
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
        {
          source = 'files',
          hidden = true,
          ignore = false,
          follow = true,
        },
      },
      sort = function(a, b)
        if a.source_id ~= b.source_id then
          return a.source_id < b.source_id
        end

        local a_in_bufdir = false
        local b_in_bufdir = false

        if buf_dir ~= '' and buf_dir then
          local normalized_buf_dir = vim.fn.fnamemodify(buf_dir, ':p')
          local normalized_a_path = vim.fn.fnamemodify(a._path, ':p')
          local normalized_b_path = vim.fn.fnamemodify(b._path, ':p')

          a_in_bufdir = vim.startswith(normalized_a_path, normalized_buf_dir)
          b_in_bufdir = vim.startswith(normalized_b_path, normalized_buf_dir)
        end

        if a_in_bufdir ~= b_in_bufdir then
          return a_in_bufdir
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
