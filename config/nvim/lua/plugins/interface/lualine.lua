--  ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
--  ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
--  ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
return function()
    local gruvbox = require('lualine.themes.gruvbox')

    gruvbox.normal.c.gui = 'italic'

    require('lualine').setup {
        options = {theme = gruvbox, disabled_filetypes = {'alpha'}},
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'filename'},
            lualine_c = {'branch'},
            lualine_x = {'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {'filename'},
            lualine_y = {},
            lualine_z = {},
        },
    }
end
