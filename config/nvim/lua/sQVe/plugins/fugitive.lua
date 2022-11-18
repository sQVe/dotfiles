-- ┏━╸╻ ╻┏━╸╻╺┳╸╻╻ ╻┏━╸
-- ┣╸ ┃ ┃┃╺┓┃ ┃ ┃┃┏┛┣╸
-- ╹  ┗━┛┗━┛╹ ╹ ╹┗┛ ┗━╸
-- Git interface and helpers.

local M = {}

M.init = function(use)
  use({ 'tpope/vim-fugitive', config = M.config, event = 'VimEnter' })
  use({ 'tpope/vim-rhubarb', after = { 'vim-fugitive' } }) -- GitHub support.
  use({ 'shumphrey/fugitive-gitlab.vim', after = { 'vim-fugitive' } }) -- GitLab support.
end

M.config = function()
  local map = require('sQVe.utils.vim').map

  vim.g.fugitive_pty = 0
  vim.g.fugitive_gitlab_domains = { 'https://git.detectify.net/' }

  map('n', '<Leader>g', ':Git<Space>', { silent = false })
  map('n', '<Leader>gb', '<Cmd>Git blame<CR>')
  map('n', '<Leader>gs', '<Cmd>vertical Git<CR>')
end

return M
