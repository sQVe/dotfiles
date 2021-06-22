--  ╻  ╻┏━╸╻ ╻╺┳╸╻  ╻┏┓╻┏━╸
--  ┃  ┃┃╺┓┣━┫ ┃ ┃  ┃┃┗┫┣╸ 
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━╸╹╹ ╹┗━╸
return function()
    vim.g.lightline = {
        active = {
            left = {{'mode', 'paste'}, {'gitbranch'}, {'filename', 'readonly'}},
            right = {{'lineinfo'}, {'percent'}, {'filetype'}}
        },
        colorscheme = 'gruvbox',
        component_function = {
            filename = 'LightlineFilename',
            gitbranch = 'fugitive#head'
        },
        enable = {tabline = 0},
        mode_map = {
            n = 'N',
            i = 'I',
            R = 'R',
            v = 'V',
            c = 'C',
            V = 'VL',
            ["<C-v>"] = 'VB'
        }
    }
end
