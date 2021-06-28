--  ┏━┓┏━┓┏┓╻╺┳┓╻ ╻╻┏━╸╻ ╻
--  ┗━┓┣━┫┃┗┫ ┃┃┃╻┃┃┃  ┣━┫
--  ┗━┛╹ ╹╹ ╹╺┻┛┗┻┛╹┗━╸╹ ╹
local M = {}
--
function M.config() vim.cmd('runtime macros/sandwich/keymap/surround.vim') end

function M.setup()
    vim.g.sandwich_no_default_key_mappings = 1
    vim.g.operator_sandwich_no_default_key_mappings = 1
end

return M
