-- ┏┓╻┏━┓╻┏━╸┏━╸
-- ┃┗┫┃ ┃┃┃  ┣╸
-- ╹ ╹┗━┛╹┗━╸┗━╸
-- Add or improve UI elements like: messages, cmdline, and lsp progress.

local M = {
  'folke/noice.nvim',
  event = 'VimEnter',
}

M.opts = {
  cmdline = { enabled = false },
  messages = { enabled = false },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    signature = {
      auto_open = {
        enabled = false,
        luasnip = false,
        trigger = false,
      },
    },
  },
  views = {
    mini = {
      position = {
        row = -2,
      },
    },
  },
}

return M
