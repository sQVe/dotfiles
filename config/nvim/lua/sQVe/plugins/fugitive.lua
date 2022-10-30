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
  vim.g.fugitive_pty = 0
  vim.g.fugitive_gitlab_domains = { 'https://git.detectify.net/' }

  vim.cmd([[
    nnoremap <Leader>G :Git<Space>
    nnoremap <silent> <Leader>gb <Cmd>Git blame<CR>
    nnoremap <silent> <Leader>gd <Cmd>Gdiffsplit<CR>
    nnoremap <silent> <Leader>gl <Cmd>vertical Git log --oneline<CR>
    nnoremap <silent> <Leader>gL <Cmd>vertical Git log --oneline %<CR>
    nnoremap <silent> <Leader>gq <Cmd>Gclog %<CR>
    nnoremap <silent> <Leader>gQ <Cmd>Gclog<CR>
    nnoremap <silent> <Leader>gmt <Cmd>DiffConflicts<CR>
    nnoremap <silent> <Leader>gs <Cmd>vertical Git<CR>
  ]])
end

return M
