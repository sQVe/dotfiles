-- ┏━┓┏━┓┏━┓╺┳╸┏━┓
-- ┣━┛┣━┫┗━┓ ┃ ┣━┫
-- ╹  ╹ ╹┗━┛ ╹ ╹ ╹
-- Paste with smart indentation.

local M = {}

M.init = function(use)
  use({ 'sickill/vim-pasta', config = M.config, event = 'BufEnter' })
end

M.config = function()
  vim.g.pasta_disabled_filetypes = {
    'alpha',
    'fugitive',
    'fugitiveblame',
    'markdown',
    'yaml',
  }
end

return M
