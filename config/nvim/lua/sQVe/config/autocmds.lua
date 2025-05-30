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

-- Equalize windows on resize.
autocmd('VimResized', {
  group = 'EqualizeWindowsOnResize',
  command = 'wincmd =',
})

-- Set active windows styling.
autocmd('WinEnter', {
  group = 'SetActiveWindowStyling',
  callback = function()
    vim.wo.colorcolumn = '80'
    vim.wo.cursorline = true
  end,
})

-- Set inactive windows styling.
autocmd('WinLeave', {
  group = 'SetInactiveWindowStyling',
  callback = function()
    vim.wo.colorcolumn = ''
    vim.wo.cursorline = false
  end,
})
