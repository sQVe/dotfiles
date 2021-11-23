-- ┏━┓╻  ┏━┓╻ ╻┏━┓
-- ┣━┫┃  ┣━┛┣━┫┣━┫
-- ╹ ╹┗━╸╹  ╹ ╹╹ ╹
return function()
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
        [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    }

    dashboard.section.buttons.val = {
        dashboard.button('ä', '📝  Find file',
                         ':lua require("plugins.navigation.telescope").find_files()<CR>'),
        dashboard.button('Ä', '📑  File Manager', ':Vifm<CR>'),
        dashboard.button('s', '🔴  Status', ':Telescope git_status<CR>'),
        dashboard.button('u', '✍   Recently Used Files',
                         ':Telescope oldfiles cwd_only=true<CR>'),
        dashboard.button('g', '🔍  Grep Word', ':Telescope live_grep<CR>'),
        dashboard.button('e', '💎  New File', ':enew<CR>'),
        dashboard.button('C', '💎  Packer Compile', ':PackerCompile<CR>'),
        dashboard.button('S', '🔃  Packer Sync', ':PackerSync<CR>'),
        dashboard.button('q', '🚪  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = {vim.fn.getcwd()}

    require('alpha').setup({
        layout = {
            {type = 'padding', val = 8}, dashboard.section.header,
            {type = 'padding', val = 4}, dashboard.section.buttons,
            {type = 'padding', val = 4}, dashboard.section.footer,
        },
        opts = {margin = 5},
    })
end
