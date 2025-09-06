-- ┏━┓╻┏━╸╻┏ ┏━╸┏━┓
-- ┣━┛┃┃  ┣┻┓┣╸ ┣┳┛
-- ╹  ╹┗━╸╹ ╹┗━╸╹┗╸
-- Fuzzy finders.

local autocmd = require('sQVe.utils.autocmd')
local buffer = require('sQVe.utils.buffer')
local path = require('sQVe.utils.path')

local BIG_FILE_THRESHOLD = 1 * 1024 * 1024 -- 1 MiB.
local MIN_PREFIX_LENGTH = 4

local buf_dir = ''
local current_buf_path = ''
local current_base = ''

local update_buf_dir = function()
  local bufnr = buffer.get_bufnr()
  local winid = vim.api.nvim_get_current_win()

  local win_config = vim.api.nvim_win_get_config(winid)
  local is_floating = win_config.relative ~= '' or win_config.external

  if not is_floating and buffer.is_valid(bufnr) then
    local buf_path = buffer.get_path(bufnr)
    if buf_path and buf_path ~= '' then
      current_buf_path = buf_path
      current_base =
        vim.fn.fnamemodify(current_buf_path, ':t:r'):gsub('%.module$', '')
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

local function common_prefix(s1, s2)
  local len = math.min(#s1, #s2)
  for i = 1, len do
    if s1:sub(i, i) ~= s2:sub(i, i) then
      return s1:sub(1, i - 1)
    end
  end
  return s1:sub(1, len)
end

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
        {
          source = 'files',
          hidden = true,
          ignore = false,
          follow = true,
        },
      },
      sort = function(a, b)
        -- Cache expensive fnamemodify calls on items.
        if not a._base then
          a._base = vim.fn.fnamemodify(a._path, ':t:r'):gsub('%.module$', '')
        end
        if not b._base then
          b._base = vim.fn.fnamemodify(b._path, ':t:r'):gsub('%.module$', '')
        end

        local has_current_buf_context = current_buf_path
          and current_buf_path ~= ''
        local a_is_current_buf = a._path == current_buf_path
        local b_is_current_buf = b._path == current_buf_path

        if has_current_buf_context then
          -- Exact match.
          local a_exact = a._base == current_base and not a_is_current_buf
          local b_exact = b._base == current_base and not b_is_current_buf

          if a_exact ~= b_exact then
            return a_exact
          end

          -- Dynamic prefix match.
          local a_prefix_len = #common_prefix(current_base, a._base)
          local b_prefix_len = #common_prefix(current_base, b._base)

          local a_prefix_match = a_prefix_len >= MIN_PREFIX_LENGTH
            and not a_is_current_buf
          local b_prefix_match = b_prefix_len >= MIN_PREFIX_LENGTH
            and not b_is_current_buf

          if a_prefix_match ~= b_prefix_match then
            return a_prefix_match
          elseif a_prefix_match and b_prefix_match then
            return a_prefix_len > b_prefix_len
          end
        end

        -- Buffer directory check.
        if buf_dir and buf_dir ~= '' then
          local a_in_bufdir = vim.startswith(a._path, buf_dir)
          local b_in_bufdir = vim.startswith(b._path, buf_dir)

          if a_in_bufdir ~= b_in_bufdir then
            return a_in_bufdir
          end
        end

        return a.text < b.text
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
