--  ┏━╸╻ ╻┏━╸╻╺┳╸╻╻ ╻┏━╸
--  ┣╸ ┃ ┃┃╺┓┃ ┃ ┃┃┏┛┣╸
--  ╹  ┗━┛┗━┛╹ ╹ ╹┗┛ ┗━╸

return function()
  vim.g.fugitive_pty = 0

  vim.cmd([[
    nnoremap <Leader>G :Git<Space>
    nnoremap <silent> <Leader>gb <Cmd>Git blame<CR>
    nnoremap <silent> <Leader>gd <Cmd>Gdiffsplit<CR>
    nnoremap <silent> <Leader>gl <Cmd>Gclog %<CR>
    nnoremap <silent> <Leader>gL <Cmd>Gclog<CR>
    nnoremap <silent> <Leader>gmt <Cmd>DiffConflicts<CR>
    nnoremap <silent> <Leader>gs <Cmd>vertical Git<CR>
  ]])
end
