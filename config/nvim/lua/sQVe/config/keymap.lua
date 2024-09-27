-- ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
-- ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
-- ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

local map = require('sQVe.utils.map')

-- Clear search matches.
map(
  'n',
  '<Esc>',
  '<Cmd>nohl<CR><Esc>',
  { desc = 'Escape and clear search highlights' }
)

-- Open command with right pinky.
map('', 'ö', ':', { desc = 'Open command-line', silent = false })
map('', 'Ö', ':', { desc = 'Open command-line', silent = false })
map('', 'qö', 'q:', { desc = 'Edit command-line', silent = false })
map('', 'qÖ', 'q:', { desc = 'Edit command-line', silent = false })

-- Escape terminal.
map('t', '<Esc><Esc>', '<C-\\><C-N>', { desc = 'Escape terminal' })

-- Add certain motions to jumplist.
map('i', '<Down>', '<C-o>gj', { desc = 'Down' })
map('i', '<Up>', '<C-o>gk', { desc = 'Up' })
map(
  '',
  '<Down>',
  '(v:count > 1 ? "m\'" . v:count : "") . \'gj\' ',
  { desc = 'Down', expr = true }
)
map(
  '',
  '<Up>',
  '(v:count > 1 ? "m\'" . v:count : "") . \'gk\' ',
  { desc = 'Up', expr = true }
)
map(
  '',
  'j',
  '(v:count > 1 ? "m\'" . v:count : "") . \'gj\' ',
  { desc = 'Down', expr = true }
)
map(
  '',
  'k',
  '(v:count > 1 ? "m\'" . v:count : "") . \'gk\' ',
  { desc = 'Up', expr = true }
)
map('', 'gj', 'j', { desc = 'Down' })
map('', 'gk', 'k', { desc = 'Up' })

-- Consistent centered search with n and N.
map(
  '',
  'n',
  "'Nn'[v:searchforward] . 'zzzv'",
  { desc = 'Next match', expr = true }
)
map(
  '',
  'N',
  "'nN'[v:searchforward] . 'zzzv'",
  { desc = 'Previous match', expr = true }
)

-- Consistent CR movement.
map('', '<S-CR>', '-')

-- Format without formatexpr.
map('', 'gq', 'gw', { desc = 'Format' })

-- Move to start and end of line.
map('n', 'H', function()
  local _, _, col, _ = unpack(vim.fn.getpos('.'))

  vim.cmd('normal! ^')
  if col == vim.fn.getpos('.')[3] then
    vim.cmd('normal! 0')
  end
end, { desc = 'Go to start of line' })
map({ 'o', 'v' }, 'H', '^', { desc = 'Go to start of line' })
map({ 'n', 'o', 'v' }, 'L', '$', { desc = 'Go to end of line' })

-- Keep cursor position when joining lines.
map('', 'J', 'mzJ`z', { desc = 'Join lines' })

-- Flip f, t, F and T repeat.
map('', ',', ';', { desc = 'Find next character' })
map('', ';', ',', { desc = 'Find previous character' })

-- Indent and un-indent without loosing selection.
map('v', '<', '<gv', { desc = 'Un-indent' })
map('v', '>', '>gv', { desc = 'Indent' })

-- Next and previous buffer.
map('', '<Tab>', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
map('', '<S-Tab>', '<Cmd>bprev<CR>', { desc = 'Previous buffer' })

-- Move between jumps.
map('n', '<C-o>', '<C-o>', { desc = 'Previous jump' })
map('n', '<C-p>', '<C-i>', { desc = 'Next jump' })

-- Move between windows.
map('n', '<C-h>', '<Cmd>wincmd h<CR>', { desc = 'Move window focus left' })
map('n', '<C-j>', '<Cmd>wincmd j<CR>', { desc = 'Move window focus down' })
map('n', '<C-k>', '<Cmd>wincmd k<CR>', { desc = 'Move window focus up' })
map('n', '<C-l>', '<Cmd>wincmd l<CR>', { desc = 'Move window focus right' })
map('n', '<C-Left>', '<Cmd>wincmd h<CR>', { desc = 'Move window focus left' })
map('n', '<C-Down>', '<Cmd>wincmd j<CR>', { desc = 'Move window focus down' })
map('n', '<C-Up>', '<Cmd>wincmd k<CR>', { desc = 'Move window focus up' })
map('n', '<C-Right>', '<Cmd>wincmd l<CR>', { desc = 'Move window focus right' })

-- Quickfix.
map('n', '<C-q>w', '<Cmd>copen<CR>', { desc = 'Open quickfix' })
map('n', '<C-q><C-w>', '<Cmd>copen<CR>', { desc = 'Open quickfix' })
map('n', '<C-q>q', '<Cmd>cclose<CR>', { desc = 'Close quickfix' })
map('n', '<C-q><C-q>', '<Cmd>cclose<CR>', { desc = 'Close quickfix' })
map('n', '<C-q>n', '<Cmd>cnext<CR>', { desc = 'Next quickfix entry' })
map('n', '<C-q><C-n>', '<Cmd>cnext<CR>', { desc = 'Next quickfix entry' })
map('n', '<C-q>p', '<Cmd>cprevious<CR>', { desc = 'Previous quickfix entry' })
map(
  'n',
  '<C-q><C-p>',
  '<Cmd>cprevious<CR>',
  { desc = 'Previous quickfix entry' }
)

-- Tabs.
map('n', '<C-t>w', '<Cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<C-t><C-w>', '<Cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<C-t>n', '<Cmd>tabnext<CR>', { desc = 'Next tab' })
map('n', '<C-t><C-n>', '<Cmd>tabnext<CR>', { desc = 'Next tab' })
map('n', '<C-t>p', '<Cmd>tabprevious<CR>', { desc = 'Previous tab' })
map('n', '<C-t><C-p>', '<Cmd>tabprevious<CR>', { desc = 'Previous tab' })
map('n', '<C-t>q', '<Cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<C-t><C-q>', '<Cmd>tabclose<CR>', { desc = 'Close tab' })

-- Spelling.
map('', '<C-s>', '<Cmd>set spell!<CR>', { desc = 'Toggle spell', remap = true })
map('i', '<C-s>', '<C-o><C-s>', { desc = 'Toggle spell', remap = true })

-- Star search but stay at same word.
map('', '<C-n>', '*N', { desc = 'Search for word or selection', remap = true })

-- Set undo breakpoints.
map('i', '!', '!<c-g>u')
map('i', '(', '(<c-g>u')
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '?', '?<c-g>u')
map('i', '[', '[<c-g>u')
map('i', '{', '{<c-g>u')

-- Search for selected text with DuckDuckGo.
map(
  'v',
  'K',
  '"oy<Esc><Cmd>Ddg<CR>',
  { desc = 'Search for selection in DuckDuckGo' }
)
