--  ┏━┓┏━┓┏━┓╺┳╸┏━╸┏━┓
--  ┣┳┛┃ ┃┃ ┃ ┃ ┣╸ ┣┳┛
--  ╹┗╸┗━┛┗━┛ ╹ ┗━╸╹┗╸
return function()
    require('project_nvim').setup {
        detection_methods = {'pattern', 'lsp'},
        manual_mode = true,
        patterns = {'.git'},
    }
end
