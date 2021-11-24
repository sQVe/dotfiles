-- ┏━╸┏┳┓
-- ┣╸ ┃┃┃
-- ╹  ╹ ╹
return function()
    require('fm-nvim').setup({
        border = 'rounded',
        mappings = {
            vert_split = '<C-v>',
            horz_split = '<C-s>',
            tabedit = '<C-t>',
            edit = '<C-e>',
            ESC = '<ESC>',
        },
    })

    vim.cmd([[
        nnoremap <silent> Ä :Vifm<CR>
        nnoremap <silent> Å :Vifm %:p:h<CR>
    ]])
end
