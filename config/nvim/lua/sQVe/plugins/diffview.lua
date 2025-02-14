-- ╺┳┓╻┏━╸┏━╸╻ ╻╻┏━╸╻ ╻
--  ┃┃┃┣╸ ┣╸ ┃┏┛┃┣╸ ┃╻┃
-- ╺┻┛╹╹  ╹  ┗┛ ╹┗━╸┗┻┛
-- Unified diff and merge view.

local M = {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewFileHistory',
    'DiffviewOpen',
  },
}

M.opts = {
  default_args = {
    DiffviewOpen = { '--imply-local' },
  },
  file_panel = {
    listing_style = 'list',
    win_config = {
      width = 40,
    },
  },
  show_help_hints = false,
  view = {
    merge_tool = {
      layout = 'diff3_mixed',
    },
  },
}

return M
