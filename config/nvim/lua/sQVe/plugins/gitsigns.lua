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
    map(
      'n',
      '<Leader>hn',
      gitsigns.next_hunk,
      { buffer = bufnr, desc = 'Next hunk' }
    )
    map(
      'n',
      '<Leader>hp',
      gitsigns.prev_hunk,
      { buffer = bufnr, desc = 'Previous hunk' }
    )

    -- Hunk actions.
    map(
      { 'n', 'v' },
      '<Leader>hs',
      gitsigns.stage_hunk,
      { buffer = bufnr, desc = 'Stage hunk' }
    )
    map(
      'n',
      '<Leader>hS',
      gitsigns.stage_buffer,
      { buffer = bufnr, desc = 'Stage buffer' }
    )
    map(
      'n',
      '<Leader>hu',
      gitsigns.undo_stage_hunk,
      { buffer = bufnr, desc = 'Unstage hunk' }
    )
    map(
      'n',
      '<Leader>hU',
      gitsigns.reset_buffer_index,
      { buffer = bufnr, desc = 'Reset buffer index' }
    )
    map(
      { 'n', 'v' },
      '<Leader>hr',
      gitsigns.reset_hunk,
      { buffer = bufnr, desc = 'Reset hunk' }
    )
    map(
      'n',
      '<Leader>hR',
      gitsigns.reset_buffer,
      { buffer = bufnr, desc = 'Reset buffer' }
    )
    map(
      'n',
      '<Leader>hi',
      gitsigns.preview_hunk,
      { buffer = bufnr, desc = 'Preview hunk' }
    )
    map('n', '<Leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, { buffer = bufnr, desc = 'Blame line' })
    map(
      'n',
      '<Leader>hq',
      gitsigns.setqflist,
      { buffer = bufnr, desc = 'List hunks in quickfix' }
    )

    map(
      { 'o', 'x' },
      'ih',
      ':<C-U>Gitsigns select_hunk<CR>',
      { buffer = bufnr, desc = 'Select hunk' }
    )
  end,
}

return M
