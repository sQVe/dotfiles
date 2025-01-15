-- ┏━┓╻┏━╸╻┏ ┏━╸┏━┓
-- ┣━┛┃┃  ┣┻┓┣╸ ┣┳┛
-- ╹  ╹┗━╸╹ ╹┗━╸╹┗╸
-- Fuzzy finders.

local BIG_FILE_THRESHOLD = 1 * 1024 * 1024 -- 1 MiB.

return {
  previews = {
    file = {
      max_size = BIG_FILE_THRESHOLD,
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
