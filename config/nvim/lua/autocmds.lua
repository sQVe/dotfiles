-- ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛┗━┛

local augroups = {}
local augroup_keys = {
  'DisableNetrw',
  'ExcludeFormatOptions',
  'Format',
  'HighlightYank',
  'ReloadBuffer',
  'SaveCommitMsg',
  'SaveNotes',
  'StopNeovimDaemons',
  'ZUpdate',
}

for _, augroup_key in ipairs(augroup_keys) do
  table.insert(augroups, vim.api.nvim_create_augroup(augroup_key, {}))
end

-- Disable Netrw.
vim.api.nvim_create_autocmd('VimEnter', {
  group = augroups.DisableNetrw,
  pattern = '*',
  command = 'silent! autocmd! FileExplorer',
})

-- Equalize splits on resize.
vim.api.nvim_create_autocmd('VimResized', {
  group = augroups.Format,
  pattern = '*',
  command = 'wincmd =',
})

-- Highlight yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroups.HighlightYank,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Force formatoptions to exclude 'o'.
vim.api.nvim_create_autocmd('FileType', {
  group = augroups.ExcludeFormatOptions,
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'o' })
  end,
})

-- Add all buffers to Z database.
vim.api.nvim_create_autocmd({ 'BufFilePost', 'BufWinEnter' }, {
  group = augroups.ZUpdate,
  pattern = '*',
  callback = 'ZUpdate',
})

-- Reload buffer on enter or focus.
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
  group = augroups.ReloadBuffer,
  pattern = '*',
  command = 'silent! !',
})

-- Save commit message for later.
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroups.SaveCommitMsg,
  pattern = { '*/.git/COMMIT_EDITMSG', '*/.git/worktrees/*/COMMIT_EDITMSG' },
  command = 'silent! call writefile(nvim_buf_get_lines(0, 0, -1, 1), "/tmp/PREV_COMMIT_EDITMSG")',
})

-- Save notes.
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroups.SaveNotes,
  pattern = '$HOME/notes/*.md',
  command = 'silent exec "!($HOME/scripts/nvim/notes-send.sh &)"',
})

-- Stop Neovim Daemons.
vim.api.nvim_create_autocmd('ExitPre', {
  group = augroups.StopNeovimDaemons,
  pattern = '*',
  command = 'silent exec "!($HOME/scripts/nvim/stop-nvim-daemons.sh &)"',
})
