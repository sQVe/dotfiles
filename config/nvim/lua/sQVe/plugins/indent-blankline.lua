-- ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
-- ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
-- ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
-- Indention guides.

local M = {}

M.init = function(use)
  use({
    'lukas-reineke/indent-blankline.nvim',
    after = 'nvim-treesitter',
    config = M.config,
  })
end

M.config = function()
  require('indent_blankline').setup({
    buftype_exclude = { 'nofile', 'terminal' },
    filetype_exclude = { 'alpha', 'help', 'packer' },
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
  })
end

return M