-- ┏┓╻┏━┓╻┏━╸┏━╸
-- ┃┗┫┃ ┃┃┃  ┣╸
-- ╹ ╹┗━┛╹┗━╸┗━╸
-- Add or improve UI elements like: messages, cmdline, and lsp progress.

local M = {
  'folke/noice.nvim',
  event = 'VimEnter',
}

M.opts = {
  cmdline = {
    view = 'cmdline',
    format = {
      cmdline = { icon = ' > ', lang = 'vim', pattern = '^:' },
      filter = { icon = ' ! ', lang = 'bash', pattern = '^:%s*!' },
      help = { pattern = '' },
      lua = {
        icon = ' lua ',
        lang = 'lua',
        pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' },
      },
      search_down = {
        icon = ' / ',
        kind = 'search',
        lang = 'regex',
        pattern = '^/',
        view = 'cmdline',
      },
      search_up = {
        icon = ' ? ',
        kind = 'search',
        lang = 'regex',
        pattern = '^%?',
        view = 'cmdline',
      },
    },
  },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
    signature = { enabled = false },
  },
  routes = {
    -- Show all messages over 4 lines in popup.
    {
      filter = { event = 'msg_show', min_height = 4 },
      view = 'popup',
    },

    -- Skip any write message.
    {
      filter = { event = 'msg_show', find = '%d+L, %d+B$' },
      opts = { skip = true },
    },

    -- Skip any "fewer lines" or "more lines" messages.
    {
      filter = { event = 'msg_show', find = '^%d+ fewer lines' },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', find = '^%d+ line less' },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', find = '^%d+ more lines?' },
      opts = { skip = true },
    },

    -- Skip any undo and redo messages.
    {
      filter = { event = 'msg_show', find = '^%d+ changes?; before' },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', find = '^%d+ changes?; after' },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', find = '^Already at newest change$' },
      opts = { skip = true },
    },

    -- Skip any < and > indent messages.
    {
      filter = { event = 'msg_show', find = '^%d+ lines? [<>]ed %d+ times?' },
      opts = { skip = true },
    },
  },
}

return M
