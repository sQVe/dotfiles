--  ╺┳┓┏━┓┏━┓╻ ╻┏┓ ┏━┓┏━┓┏━┓╺┳┓
--   ┃┃┣━┫┗━┓┣━┫┣┻┓┃ ┃┣━┫┣┳┛ ┃┃
--  ╺┻┛╹ ╹┗━┛╹ ╹┗━┛┗━┛╹ ╹╹┗╸╺┻┛
return function()
    local function get_header()
        return {
            '', '', '',
            '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
            '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
            '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
            '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
            '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
            '', '', ''
        }
    end
    local function get_footer() return {'', '', '', vim.fn.getcwd()} end

    vim.g.dashboard_custom_header = get_header()
    vim.g.dashboard_custom_footer = get_footer()

    -- LuaFormatter off
    vim.g.dashboard_custom_section = {
        a = {description = {'✍   Recently Used Files                            '}, command = 'History'},
        b = {description = {'🔴  Status                                         '}, command = 'GitFiles?'},
        c = {description = {'📝  Find File                                      '}, command = 'Files'},
        d = {description = {'📑  File Manager                                   '}, command = 'FloatermNew vifm'},
        e = {description = {'🔍  Find Word                                      '}, command = 'Rg'},
        g = {description = {'💎  New File                                       '}, command = 'enew'},
        h = {description = {'🔃  Packer Sync                                    '}, command = 'PackerSync'},
        i = {description = {'⚙   Packer Compile                                 '}, command = 'PackerCompile'}
    }
    -- LuaFormatter on

    vim.cmd([[
        hi! link DashboardHeader GruvboxYellow
        hi! link DashboardCenter GruvboxFg1
        hi! link DashboardShortcut GruvboxGreen
        hi! link DashboardFooter GruvboxGray
    ]])
end