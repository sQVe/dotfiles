-- ┏━╸┏┳┓
-- ┣╸ ┃┃┃
-- ╹  ╹ ╹
return function()
    require('fm-nvim').setup({
        border = 'rounded',
        mappings = {
            edit = '<C-e>',
            horz_split = '<C-s>',
            vert_split = '<C-v>',
            tabedit = '<C-t>',
            ESC = '<ESC>',
        },
    })

    vim.cmd([[
        nnoremap <silent> Ä :Vifm<CR>
        nnoremap <silent> Å :Vifm %:p:h<CR>
    ]])
end
