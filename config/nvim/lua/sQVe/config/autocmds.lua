-- ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓┏━┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃┗━┓
-- ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛┗━┛

local autocmd = require('sQVe.utils.autocmd')
local buffer = require('sQVe.utils.buffer')

local search_count_ns = vim.api.nvim_create_namespace('search_count')

autocmd('CursorMoved', {
  group = 'UpdateSearchCount',
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, search_count_ns, 0, -1)

    if vim.v.hlsearch ~= 1 then
      return
    end

    local pattern = vim.fn.getreg('/')
    if pattern == '' then
      return
    end

    local match_ok, match_result =
      pcall(vim.fn.match, vim.fn.getline('.'), pattern)
    if not match_ok or match_result == -1 then
      return
    end

    local ok, result = pcall(vim.fn.searchcount, { maxcount = 9999 })
    if not ok or result.total == 0 then
      return
    end

    local text = string.format('%d/%d ', result.current, result.total)
    vim.api.nvim_buf_set_extmark(0, search_count_ns, vim.fn.line('.') - 1, 0, {
      virt_text = { { text, 'Comment' } },
      virt_text_pos = 'right_align',
    })
  end,
})

autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = 'ClearSearchCount',
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, search_count_ns, 0, -1)
  end,
})

-- Delete certain buffers on window close.
autocmd('WinClosed', {
  group = 'DeleteCertainBuffersOnWindowClose',
  callback = function(args)
    local bufnr = vim.fn.winbufnr(tonumber(args.match))

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
  command = 'silent! checktime',
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
autocmd({ 'VimEnter', 'WinEnter' }, {
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

-- Remove kitty padding on enter.
autocmd('VimEnter', {
  group = 'RemoveKittyPaddingOnEnter',
  callback = function()
    if vim.env.KITTY_PID then
      vim.fn.system('kitten @ set-spacing padding=0')
    end
  end,
})

-- Restore kitty padding on leave.
autocmd('VimLeavePre', {
  group = 'RestoreKittyPaddingOnLeave',
  callback = function()
    if vim.env.KITTY_PID then
      vim.fn.system(
        'kitten @ set-spacing padding-top=4 padding-right=8 padding-bottom=4 padding-left=8'
      )
    end
  end,
})
