--  ╻ ╻┏━┓┏┓╻╻┏━┓
--  ┃┏┛┗━┓┃┗┫┃┣━┛
--  ┗┛ ┗━┛╹ ╹╹╹

return function()
  vim.cmd([[
    let g:vsnip_snippet_dir = expand('$XDG_CONFIG_HOME/nvim/snippets')
    let g:vsnip_filetypes = {}
    let g:vsnip_filetypes.javascriptreact = ['javascript']
    let g:vsnip_filetypes.typescript = ['javascript']
    let g:vsnip_filetypes.typescriptreact = ['javascript', 'javascriptreact', 'typescript']
  ]])

  -- Expand or jump.
  vim.cmd([[
    imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ''
    smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ''
  ]])
end