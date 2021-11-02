--  ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
--  ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
--  ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
return function()
    require('lualine').setup {
        options = {
            icons_enabled = false,
            theme = 'gruvbox',
            component_separators = {'', ''},
            section_separators = {'', ''},
            disabled_filetypes = {'dashboard'},
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'filename'},
            lualine_c = {'branch'},
            lualine_x = {'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'},
        },
    }
end
