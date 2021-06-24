--  ╻ ╻┏━┓┏┓╻╻┏━┓
--  ┃┏┛┗━┓┃┗┫┃┣━┛
--  ┗┛ ┗━┛╹ ╹╹╹
return function()
    vim.cmd([[
      let g:vsnip_snippet_dir = expand('$XDG_CONFIG_HOME/nvim/snippets')
      let g:vsnip_filetypes = {}
      let g:vsnip_filetypes.javascriptreact = ['javascript', 'react']
      let g:vsnip_filetypes.typescript = ['javascript', ]
      let g:vsnip_filetypes.typescriptreact = ['javascript', 'react', 'typescript']
    ]])

    -- Expand or jump.
    vim.cmd([[
      imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
    ]])
end
