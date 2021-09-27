--  ┏━┓┏━┓┏┓╻╺┳┓╻ ╻╻┏━╸╻ ╻
--  ┗━┓┣━┫┃┗┫ ┃┃┃╻┃┃┃  ┣━┫
--  ┗━┛╹ ╹╹ ╹╺┻┛┗┻┛╹┗━╸╹ ╹
local M = {}

function M.config()
    vim.cmd([[
        runtime macros/sandwich/keymap/surround.vim
        xmap gs <Plug>(operator-sandwich-add)
    ]])
end

function M.setup()
    vim.g.operator_sandwich_no_default_key_mappings = 1
    vim.g.sandwich_no_default_key_mappings = 1
    vim.g.textobj_sandwich_no_default_key_mappings = 1
end

return M
