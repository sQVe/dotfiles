-- ┏━┓┏┓╻╻┏━┓┏━┓┏━╸╺┳╸┏━┓
-- ┗━┓┃┗┫┃┣━┛┣━┛┣╸  ┃ ┗━┓
-- ┗━┛╹ ╹╹╹  ╹  ┗━╸ ╹ ┗━┛
-- Add VSCode snippet definition support.

local M = {
  'garymjr/nvim-snippets',
  event = 'InsertEnter',
}

M.opts = {
  extended_filetypes = {
    javascriptreact = { 'javascript' },
    typescript = { 'javascript' },
    typescriptreact = { 'javascript', 'javascriptreact', 'typescript' },
  },
  search_paths = { vim.fn.expand('$XDG_CONFIG_HOME/nvim/snippets') },
}

return M
