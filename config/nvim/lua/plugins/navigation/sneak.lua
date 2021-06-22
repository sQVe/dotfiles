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
end
