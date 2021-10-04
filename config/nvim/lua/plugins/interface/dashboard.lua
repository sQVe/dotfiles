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
        a = {description = {'📝  Find File                                      '}, command = 'lua require("plugins.navigation.telescope").find_root_files()'},
        b = {description = {'🔴  Status                                         '}, command = 'Telescope git_status'},
        c = {description = {'✍   Recently Used Files                            '}, command = 'Telescope oldfiles'},
        d = {description = {'📑  File Manager                                   '}, command = 'FloatermNew vifm'},
        e = {description = {'🔍  Find Word                                      '}, command = 'Telescope live_grep'},
        g = {description = {'💎  New File                                       '}, command = 'enew'},
        h = {description = {'⚙   Packer Compile                                 '}, command = 'PackerCompile'},
        i = {description = {'🔃  Packer Sync                                    '}, command = 'PackerSync'}
    }
    -- LuaFormatter on

    vim.cmd([[
        hi! link DashboardHeader GruvboxYellow
        hi! link DashboardCenter GruvboxFg1
        hi! link DashboardShortcut GruvboxGreen
        hi! link DashboardFooter GruvboxGray
    ]])
end
