-- ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
-- ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
-- ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

local map = require('sQVe.utils.vim').map

-- Clear search matches.
map('n', '<Esc><Esc>', '<Cmd>nohl<CR>', { desc = 'Clear search matches' })

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
  '(v:count > 4 ? "m\'" . v:count : "") . \'gj\' ',
  { desc = 'Down', expr = true }
)
map(
  '',
  '<Up>',
  '(v:count > 4 ? "m\'" . v:count : "") . \'gk\' ',
  { desc = 'Up', expr = true }
)
map(
  '',
  'j',
  '(v:count > 4 ? "m\'" . v:count : "") . \'gj\' ',
  { desc = 'Down', expr = true }
)
map(
  '',
  'k',
  '(v:count > 4 ? "m\'" . v:count : "") . \'gk\' ',
  { desc = 'Up', expr = true }
)
map('', 'gj', 'j', { desc = 'Down' })
map('', 'gk', 'k', { desc = 'Up' })

-- Consistent centered search with n and N.
map(
  '',
  'n',
  '\'Nn\'[v:searchforward] . \'zzzv\'',
  { desc = 'Next match', expr = true }
)
map(
  '',
  'N',
  '\'nN\'[v:searchforward] . \'zzzv\'',
  { desc = 'Previous match', expr = true }
)

-- Consistent CR movement.
map('', '<S-CR>', '-')

-- Keep cursor position when joining lines.
map('', 'J', 'mzJ`z', { desc = 'Join lines' })

-- Flip f, t, F and T repeat.
map('', ',', ';', { desc = 'Find next character' })
map('', ';', ',', { desc = 'Find previous character' })

-- Indent and un-indent without loosing selection.
map('v', '<', '<gv', { desc = 'Un-indent' })
map('v', '>', '>gv', { desc = 'Indent' })

-- Term.
map(
  'n',
  '<Leader>t',
  '<Cmd>BTerm<CR>',
  { desc = 'Open terminal (buffer directory)' }
)
map('n', '<Leader>T', '<Cmd>Term<CR>', { desc = 'Open terminal' })

-- File manager.
map(
  'n',
  '<Leader>f',
  '<Cmd>BFileManager<CR>',
  { desc = 'Open file manager (buffer directory)' }
)
map('n', '<Leader>F', '<Cmd>FileManager<CR>', { desc = 'Open file manager' })

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

-- Spell completion.
map('i', '<C-x><C-s>', '<C-x>s', { desc = 'Open spell completion' })

-- Toggle settings.
map(
  'n',
  'yoc',
  ':set conceallevel=<C-r>=&conceallevel == 0 ? \'2\' : \'0\'<CR><CR>',
  { desc = 'Toggle conceal' }
)
map('n', 'yol', '<Cmd>set cursorline!<CR>', { desc = 'Toggle cursorline' })
map('n', 'yon', '<Cmd>set number!<CR>', { desc = 'Toggle number' })
map(
  'n',
  'yor',
  '<Cmd>set relativenumber!<CR>',
  { desc = 'Toggle relativenumber' }
)
map('n', 'yow', '<Cmd>set wrap!<CR>', { desc = 'Toggle wrap' })
map('n', 'yos', '<Cmd>set spell!<CR>', { desc = 'Toggle spell' })
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

-- Open file or URL with mimeo.
map(
  'n',
  'gx',
  '<Cmd>silent execute "!mimeo " . shellescape(expand(\'<cfile>\'))<CR>',
  { desc = 'Open file or URL with mimeo' }
)
