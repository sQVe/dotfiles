--  ┏━┓┏┓╻┏━╸┏━┓╻┏
--  ┗━┓┃┗┫┣╸ ┣━┫┣┻┓
--  ┗━┛╹ ╹┗━╸╹ ╹╹ ╹
return function()
    vim.cmd([[
        let g:sneak#absolute_dir = 1
        let g:sneak#label = 1
        let g:sneak#label_esc = "\<CR>"
        let g:sneak#prompt = '> '
        let g:sneak#target_labels = ";sftunqåäöSFGHLTUNRMQZÅÄÖ/?0"
    ]])

    vim.cmd([[
        map F <Plug>Sneak_F
        map T <Plug>Sneak_T
        map f <Plug>Sneak_f
        map t <Plug>Sneak_t
        nmap <expr> , sneak#is_sneaking() ? '<Plug>Sneak_;' : ','
        nmap <expr> ; sneak#is_sneaking() ? '<Plug>Sneak_,' : ','
    ]])
end
