-- ┏┓╻┏━┓╻┏━╸┏━╸
-- ┃┗┫┃ ┃┃┃  ┣╸
-- ╹ ╹┗━┛╹┗━╸┗━╸
-- Add or improve UI elements like: messages, cmdline, and lsp progress.

local M = {
  'folke/noice.nvim',
}

M.opts = {
  cmdline = {
    view = 'cmdline',
    format = {
      cmdline = { pattern = '^:', icon = '', lang = 'vim' },
      filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
      help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
      lua = {
        pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' },
        icon = '',
        lang = 'lua',
      },
      search_down = {
        kind = 'search',
        pattern = '^/',
        icon = ' ',
        lang = 'regex',
      },
      search_up = {
        kind = 'search',
        pattern = '^%?',
        icon = ' ',
        lang = 'regex',
      },
    },
  },
  notify = { enabled = false },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    signature = { enabled = false },
    documentation = {
      view = 'hover',
      opts = {
        lang = 'markdown',
        replace = true,
        render = 'plain',
        format = { '{message}' },
        win_options = { concealcursor = 'n', conceallevel = 3 },
      },
    },
  },
}

return M
