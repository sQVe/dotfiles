-- ┏━┓┏┓╻╻┏━┓┏━┓┏━╸╺┳╸┏━┓
-- ┗━┓┃┗┫┃┣━┛┣━┛┣╸  ┃ ┗━┓
-- ┗━┛╹ ╹╹╹  ╹  ┗━╸ ╹ ┗━┛
-- Add VSCode snippet definition support.

local M = {
  'garymjr/nvim-snippets',
  dev = true,
  event = 'InsertEnter',
}

M.opts = {
  extended_filetypes = {
    javascriptreact = { 'javascript' },
    typescript = { 'javascript' },
    typescriptreact = { 'typescript', 'javascriptreact' },
  },
  search_paths = { vim.fn.expand('$DOTFILES/config/nvim/snippets') },
}

return M
