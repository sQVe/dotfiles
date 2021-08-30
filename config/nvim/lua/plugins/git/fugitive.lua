--  ┏━╸╻ ╻┏━╸╻╺┳╸╻╻ ╻┏━╸
--  ┣╸ ┃ ┃┃╺┓┃ ┃ ┃┃┏┛┣╸
--  ╹  ┗━┛┗━┛╹ ╹ ╹┗┛ ┗━╸
return function()
    vim.g.fugitive_pty = 0

    vim.cmd([[
        nnoremap <silent> <Leader>gb :Git blame<CR>
        nnoremap <silent> <Leader>gc :Git commit --verbose<CR>
        nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
        nnoremap <silent> <Leader>gf :Git fetch<CR>
        nnoremap <silent> <Leader>gmt :MergetoolToggle<CR>
        nnoremap <silent> <Leader>gp :Git push<CR>
        nnoremap <silent> <Leader>gr :Gread<CR>
        nnoremap <silent> <Leader>gs :vertical Git<CR>
        nnoremap <silent> <Leader>gw :Gwrite<CR>
    ]])
end
