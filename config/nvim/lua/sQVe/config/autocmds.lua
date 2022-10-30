-- ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛┗━┛

local autocmd = require('sQVe.utils.vim').autocmd

local augroups = {}
local augroup_keys = {
  'ExcludeFormatOptions',
  'HighlightYank',
  'ReloadBuffer',
  'SaveCommitMsg',
  'StopNeovimDaemons',
  'VimResized',
}

for _, augroup_key in ipairs(augroup_keys) do
  table.insert(augroups, vim.api.nvim_create_augroup(augroup_key, {}))
end

-- Force formatoptionsasd to exclude 'o'.
autocmd('FileType', {
  group = augroups.ExcludeFormatOptions,
  callback = function()
    vim.opt_local.formatoptions:remove({ 'o' })
  end,
})

-- Highlight yanked text.
autocmd('TextYankPost', {
  group = augroups.HighlightYank,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Reload buffer on enter or focus.
autocmd(
  { 'BufEnter', 'FocusGained' },
  { group = augroups.ReloadBuffer, command = 'silent! !' }
)

-- Save commit message for later.
autocmd('BufWritePost', {
  group = augroups.SaveCommitMsg,
  pattern = { '*/.git/COMMIT_EDITMSG', '*/.git/worktrees/*/COMMIT_EDITMSG' },
  command = 'silent! call writefile(nvim_buf_get_lines(0, 0, -1, 1), "/tmp/PREV_COMMIT_EDITMSG")',
})

-- Stop Neovim Daemons.
autocmd('ExitPre', {
  group = augroups.StopNeovimDaemons,
  command = 'silent exec "!('
    .. vim.fn.expand('$HOME')
    .. '/scripts/nvim/stop-nvim-daemons.sh &)"',
})

-- Use internal formatting for bindings like gq.
autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})
