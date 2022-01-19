--  ┏┳┓┏━┓╻┏┓╻
--  ┃┃┃┣━┫┃┃┗┫
--  ╹ ╹╹ ╹╹╹ ╹

-- Use filetype.lua for filetype lookup.
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Disable providers.
vim.g.loaded_node_provider = 1
vim.g.loaded_perl_provider = 1
vim.g.loaded_python3_provider = 1
vim.g.loaded_python_provider = 1
vim.g.loaded_ruby_provider = 1
vim.g.python_host_skip_check = 1

--  Disable unsued neovim features.
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Netrw and matchit used by fugitive.
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_matchit = 1

require('options')

-- Load async due to packer_compiled.
vim.defer_fn(function()
  require('plugins')
end, 0)
