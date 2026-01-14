-- ┏┳┓┏━┓┏━┓╻┏ ╺┳┓┏━┓╻ ╻┏┓╻
-- ┃┃┃┣━┫┣┳┛┣┻┓ ┃┃┃ ┃┃╻┃┃┗┫
-- ╹ ╹╹ ╹╹┗╸╹ ╹╺┻┛┗━┛┗┻┛╹ ╹
-- Markdown specific settings.

-- Disable conceal.
vim.opt_local.conceallevel = 0

-- Enable spellchecking.
vim.opt_local.spell = true

-- Do not expand tabs to spaces.
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 3

-- Improve text formatting.
vim.opt_local.formatoptions:append('t')
vim.opt_local.textwidth = 80

-- Move cursor to end for Claude Code prompts.
local bufname = vim.api.nvim_buf_get_name(0)
if bufname:match('^/tmp/claude%-prompt%-.*%.md$') then
  vim.cmd('normal! G$')
end
