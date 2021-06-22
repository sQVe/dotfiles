--  ┏━┓╻┏━╸┏┓╻┏━┓╺┳╸╻ ╻┏━┓┏━╸
--  ┗━┓┃┃╺┓┃┗┫┣━┫ ┃ ┃ ┃┣┳┛┣╸
--  ┗━┛╹┗━┛╹ ╹╹ ╹ ╹ ┗━┛╹┗╸┗━╸
return function()
    require'lsp_signature'.on_attach({
        floating_window = true,
        hint_enable = false
    })
end
