--  ╻ ╻╻  ╺┳╸╻┏━┓┏┓╻╻┏━┓┏━┓
--  ┃ ┃┃   ┃ ┃┗━┓┃┗┫┃┣━┛┗━┓
--  ┗━┛┗━╸ ╹ ╹┗━┛╹ ╹╹╹  ┗━┛
return function()
    vim.g.UltiSnipsExpandTrigger = "<C-l>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
    vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
    vim.g.UltiSnipsSnippetDirectories = {
        os.getenv('XDG_DATA_HOME') .. '/ultisnips'
    }
end
