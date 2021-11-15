-- ┏━╸┏┳┓
-- ┣╸ ┃┃┃
-- ╹  ╹ ╹
return function()
    require('fm-nvim').setup({border = 'rounded'})

    vim.cmd([[
        nnoremap <silent> Ä :Vifm<CR>
        nnoremap <silent> Å :Vifm %:p:h<CR>
    ]])
end
