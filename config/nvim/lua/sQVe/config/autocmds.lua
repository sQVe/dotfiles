-- ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛┗━┛

local autocmd = require('sQVe.utils.vim').autocmd
local augroup = require('sQVe.utils.vim').augroup

local augroups = {}
local augroup_keys = {
  'ExcludeFormatOptions',
  'HighlightYank',
  'LspAttach',
  'ReloadBuffer',
  'SaveCommitMsg',
  'VimResized',
}

for _, augroup_key in ipairs(augroup_keys) do
  table.insert(augroups, augroup(augroup_key))
end

-- Force formatoptions to exclude 'o'.
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

-- Set settings on LSP attach.
autocmd('LspAttach', {
  group = augroups.LspAttach,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Disable Semantic Tokens.
    -- NOTE: Reevaluate this once it's supported by gruvbox.nvim
    -- (see https://github.com/ellisonleao/gruvbox.nvim/issues/158).
    client.server_capabilities.semanticTokensProvider = nil

    vim.bo[args.buf].formatexpr = nil
  end,
})

autocmd('VimResized', {
  group = augroups.VimResized,
  command = 'wincmd =',
})
