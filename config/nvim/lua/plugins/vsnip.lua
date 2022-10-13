-- ╻ ╻┏━┓┏┓╻╻┏━┓
-- ┃┏┛┗━┓┃┗┫┃┣━┛
-- ┗┛ ┗━┛╹ ╹╹╹
-- Snippet support.

local M = {}

M.init = function(use)
  use({ 'hrsh7th/vim-vsnip', setup = M.setup, after = 'nvim-cmp' })
end

M.setup = function()
  vim.cmd([[
    let g:vsnip_snippet_dir = expand('$XDG_CONFIG_HOME/nvim/snippets')
    let g:vsnip_filetypes = {}
    let g:vsnip_filetypes.javascript = ['hooks']
    let g:vsnip_filetypes.javascriptreact = ['javascript', 'hooks']
    let g:vsnip_filetypes.typescript = ['javascript', 'hooks']
    let g:vsnip_filetypes.typescriptreact = ['javascript', 'javascriptreact', 'typescript', 'hooks']
  ]])

  -- Expand or jump.
  vim.cmd([[
    imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ''
    smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ''
  ]])
end

return M
