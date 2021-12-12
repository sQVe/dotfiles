--  ┏━┓┏━┓┏┓╻╺┳┓╻ ╻╻┏━╸╻ ╻
--  ┗━┓┣━┫┃┗┫ ┃┃┃╻┃┃┃  ┣━┫
--  ┗━┛╹ ╹╹ ╹╺┻┛┗┻┛╹┗━╸╹ ╹

local M = {}

function M.config()
  vim.cmd([[
    source $DOTFILES/config/nvim/macros/sandwich/keymap/surround.vim
  ]])
end

function M.setup()
  vim.g.operator_sandwich_no_default_key_mappings = 1
  vim.g.sandwich_no_default_key_mappings = 1
  vim.g.textobj_sandwich_no_default_key_mappings = 1
end

return M
