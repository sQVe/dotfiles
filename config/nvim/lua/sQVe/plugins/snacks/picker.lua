-- ┏━┓╻┏━╸╻┏ ┏━╸┏━┓
-- ┣━┛┃┃  ┣┻┓┣╸ ┣┳┛
-- ╹  ╹┗━╸╹ ╹┗━╸╹┗╸
-- Fuzzy finders.

local BIG_FILE_THRESHOLD = 1 * 1024 * 1024 -- 1 MiB.

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
      multi = {
        { source = 'buffers', format = 'file', current = false },
        'files',
      },
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
