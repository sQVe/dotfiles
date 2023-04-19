-- ┏━╸╻ ╻┏━╸╻╺┳╸╻╻ ╻┏━╸
-- ┣╸ ┃ ┃┃╺┓┃ ┃ ┃┃┏┛┣╸
-- ╹  ┗━┛┗━┛╹ ╹ ╹┗┛ ┗━╸
-- Git interface and helpers.

local M = {
  'tpope/vim-fugitive',
  dependencies = {
    'tpope/vim-rhubarb', -- GitHub support.
    'shumphrey/fugitive-gitlab.vim', -- GitLab support.
  },
  cmd = { 'Git', 'GBrowse' },
  keys = {
    { '<Leader>gg', ':Git<Space>', desc = 'Input Git command' },
    { '<Leader>gb', '<Cmd>Git blame<CR>', desc = 'Open blame sidebar' },
    { '<Leader>gs', '<Cmd>vertical Git<CR>', desc = 'Open status window' },
  },
}

M.config = function()
  vim.g.fugitive_pty = 0
  vim.g.fugitive_gitlab_domains = { 'https://git.detectify.net/' }
end

return M
