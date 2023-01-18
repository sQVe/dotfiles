-- ┏━╸╻╺┳╸┏━┓╻┏━╸┏┓╻┏━┓
-- ┃╺┓┃ ┃ ┗━┓┃┃╺┓┃┗┫┗━┓
-- ┗━┛╹ ╹ ┗━┛╹┗━┛╹ ╹┗━┛
-- Git gutter signs.

local M = {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
}

M.opts = {
  on_attach = function(bufnr)
    local gitsigns = package.loaded.gitsigns
    local map = require('sQVe.utils.vim').map

    -- Move to hunks.
    map('n', '<Leader>hn', gitsigns.next_hunk, { buffer = bufnr })
    map('n', '<Leader>hp', gitsigns.prev_hunk, { buffer = bufnr })

    -- Hunk actions.
    map({ 'n', 'v' }, '<Leader>hs', gitsigns.stage_hunk, { buffer = bufnr })
    map('n', '<Leader>hS', gitsigns.stage_buffer, { buffer = bufnr })
    map('n', '<Leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr })
    map('n', '<Leader>hU', gitsigns.reset_buffer_index, { buffer = bufnr })
    map({ 'n', 'v' }, '<Leader>hr', gitsigns.reset_hunk, { buffer = bufnr })
    map('n', '<Leader>hR', gitsigns.reset_buffer, { buffer = bufnr })
    map('n', '<Leader>hi', gitsigns.preview_hunk, { buffer = bufnr })

    -- Blame current line.
    map('n', '<Leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, { buffer = bufnr })

    -- List hunks in current buffer in quickfix window.
    map('n', '<Leader>hq', gitsigns.setqflist, { buffer = bufnr })

    map(
      { 'o', 'x' },
      'ih',
      ':<C-U>Gitsigns select_hunk<CR>',
      { buffer = bufnr }
    )
  end,
}

return M
