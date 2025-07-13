-- ┏┳┓┏━┓┏━┓╻┏ ╺┳┓┏━┓╻ ╻┏┓╻
-- ┃┃┃┣━┫┣┳┛┣┻┓ ┃┃┃ ┃┃╻┃┃┗┫
-- ╹ ╹╹ ╹╹┗╸╹ ╹╺┻┛┗━┛┗┻┛╹ ╹
-- Markdown specific settings.

-- Enable conceal.
vim.opt_local.conceallevel = 2

-- Enable spellchecking.
vim.opt_local.spell = true

-- Do not expand tabs to spaces.
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 3

-- Improve text formatting.
vim.opt_local.formatoptions:append('t')
vim.opt_local.textwidth = 80
