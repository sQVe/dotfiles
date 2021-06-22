--  ╺┳╸┏━┓┏━╸┏━╸┏━┓╻╺┳╸╺┳╸┏━╸┏━┓
--   ┃ ┣┳┛┣╸ ┣╸ ┗━┓┃ ┃  ┃ ┣╸ ┣┳┛
--   ╹ ╹┗╸┗━╸┗━╸┗━┛╹ ╹  ╹ ┗━╸╹┗╸
return function()
    vim.o.foldmethod = 'expr'
    vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')

    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'bash', 'css', 'dockerfile', 'go', 'gomod', 'graphql', 'html',
            'javascript', 'jsdoc', 'json', 'jsonc', 'lua', 'scss', 'tsx',
            'typescript', 'yaml'
        },
        highlight = {enable = true},
        indent = {enable = true},
        rainbow = {enable = true, extended_mode = true}
    }
end
