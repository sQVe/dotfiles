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
    { '<Leader>gg', ':Git<Space>', desc = 'Input commmand' },
    { '<Leader>gb', '<Cmd>Git blame<CR>', desc = 'Blame' },
    { '<Leader>gs', '<Cmd>vertical Git<CR>', desc = 'Status' },
  },
}

M.config = function()
  vim.g.fugitive_pty = 0
  vim.g.fugitive_gitlab_domains = { 'https://git.detectify.net/' }
end

return M
