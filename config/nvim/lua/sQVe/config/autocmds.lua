-- ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛┗━┛

local autocmd = require('sQVe.utils.autocmd')
local buffer = require('sQVe.utils.buffer')

-- Delete certain buffers on window close.
autocmd('WinClosed', {
  group = 'DeleteCertainBuffersOnWindowClose',
  callback = function(args)
    local bufnr = args.buf

    if
      buffer.is_valid(bufnr)
      and buffer.is_ignored(bufnr)
      and not buffer.is_saved(bufnr)
    then
      require('mini.bufremove').delete(bufnr)
    end
  end,
})

-- Force formatoptions to exclude 'o'.
autocmd('FileType', {
  group = 'ForceFormatOptions',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'o' })
  end,
})

-- Highlight yanked text.
autocmd('TextYankPost', {
  group = 'HighlightYankedText',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Reload buffer on enter or focus.
autocmd({ 'BufEnter', 'FocusGained' }, {
  group = 'ReloadBufferOnEnterOrFocus',
  command = 'silent! !',
})

-- Save commit message for later.
autocmd('BufWritePost', {
  group = 'SaveCommitMessageForLater',
  pattern = { '*/.git/COMMIT_EDITMSG', '*/.git/worktrees/*/COMMIT_EDITMSG' },
  command = 'silent! call writefile(nvim_buf_get_lines(0, 0, -1, 1), "/tmp/PREV_COMMIT_EDITMSG")',
})

-- Disable format expression on LSP attach.
autocmd('LspAttach', {
  group = 'DisableFormatExpressionOnLspAttach',
  callback = function(args)
    -- Use default formatexpr.
    vim.bo[args.buf].formatexpr = nil
  end,
})

-- Spawn Neovim daemons script on exit.
autocmd('ExitPre', {
  group = 'SpawnNeovimDaemonsScriptOnExit',
  callback = function()
    vim.fn.jobstart(
      vim.fn.expand('$SCRIPTS') .. '/nvim/stop-nvim-daemons.sh',
      { detach = true }
    )
  end,
})

-- Equalize windows on resize.
autocmd('VimResized', {
  group = 'EqualizeWindowsOnResize',
  command = 'wincmd =',
})
