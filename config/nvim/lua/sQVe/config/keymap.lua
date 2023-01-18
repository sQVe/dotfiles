-- ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
-- ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
-- ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

local map = require('sQVe.utils.vim').map

-- Remove search highlight.
map('n', '<Esc><Esc>', '<Cmd>nohl<CR>')

-- Open command with right pinky.
map('', 'ö', ':', { silent = false })
map('', 'Ö', ':', { silent = false })
map('', 'qö', 'q:', { silent = false })
map('', 'qÖ', 'q:', { silent = false })

-- Escape terminal.
map('t', '<Esc><Esc>', '<C-\\><C-N>')

-- Add certain motions to jumplist.
map('i', '<Down>', '<C-o>gj')
map('i', '<Up>', '<C-o>gk')
map(
  '',
  '<Down>',
  '(v:count > 4 ? "m\'" . v:count : "") . \'gj\' ',
  { expr = true }
)
map(
  '',
  '<Up>',
  '(v:count > 4 ? "m\'" . v:count : "") . \'gk\' ',
  { expr = true }
)
map('', 'j', '(v:count > 4 ? "m\'" . v:count : "") . \'gj\' ', { expr = true })
map('', 'k', '(v:count > 4 ? "m\'" . v:count : "") . \'gk\' ', { expr = true })
map('', 'k', '(v:count > 4 ? "m\'" . v:count : "") . \'gk\' ', { expr = true })
map('', 'gj', 'j')
map('', 'gk', 'k')

-- Consistent centered search with n and N.
map('', 'n', '\'Nn\'[v:searchforward] . \'zzzv\'', { expr = true })
map('', 'N', '\'nN\'[v:searchforward] . \'zzzv\'', { expr = true })

-- Consistent CR movement.
map('', '<S-CR>', '-')

-- Keep cursor position when joining lines.
map('', 'J', 'mzJ`z')

-- Next and previous buffer.
map('', '<Tab>', '<Cmd>bnext<CR>')
map('', '<S-Tab>', '<Cmd>bprev<CR>')

-- Flip f, t, F and T repeat.
map('', ',', ';')
map('', ';', ',')

-- Indent and un-indent without loosing selection.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Term.
map('n', '<Leader>t', '<Cmd>BTerm<CR>')
map('n', '<Leader>T', '<Cmd>Term<CR>')

-- File manager.
map('n', '<Leader>f', '<Cmd>BFileManager<CR>')
map('n', '<Leader>F', '<Cmd>FileManager<CR>')

-- Move between jumps.
map('n', '<C-o>', '<C-o>')
map('n', '<C-p>', '<C-i>')

-- Move between windows.
map('n', '<C-h>', '<Cmd>wincmd h<CR>')
map('n', '<C-j>', '<Cmd>wincmd j<CR>')
map('n', '<C-k>', '<Cmd>wincmd k<CR>')
map('n', '<C-l>', '<Cmd>wincmd l<CR>')
map('n', '<C-Left>', '<Cmd>wincmd h<CR>')
map('n', '<C-Down>', '<Cmd>wincmd j<CR>')
map('n', '<C-Up>', '<Cmd>wincmd k<CR>')
map('n', '<C-Right>', '<Cmd>wincmd l<CR>')

-- Quickfix.
map('n', '<C-q>w', '<Cmd>copen<CR>')
map('n', '<C-q><C-w>', '<Cmd>copen<CR>')
map('n', '<C-q>q', '<Cmd>cclose<CR>')
map('n', '<C-q><C-q>', '<Cmd>cclose<CR>')
map('n', '<C-q>n', '<Cmd>cnext<CR>')
map('n', '<C-q><C-n>', '<Cmd>cnext<CR>')
map('n', '<C-q>p', '<Cmd>cprevious<CR>')
map('n', '<C-q><C-p>', '<Cmd>cprevious<CR>')

-- Tabs.
map('n', '<Leader>n', '<Cmd>tabnew<CR>')
map('n', '<Leader>q', '<Cmd>tabclose<CR>')

-- Spell completion.
map('i', '<C-x><C-s>', '<C-x>s')

-- Toggle settings.
map(
  'n',
  'yoc',
  ':set conceallevel=<C-r>=&conceallevel == 0 ? \'2\' : \'0\'<CR><CR>'
)
map('n', 'ol', '<Cmd>set cursorline!<CR>')
map('n', 'yon', '<Cmd>set number!<CR>')
map('n', 'yor', '<Cmd>set relativenumber!<CR>')
map('n', 'yos', '<Cmd>set spell!<CR>')
map('n', 'yow', '<Cmd>set wrap!<CR>')
map('i', '<C-s>', '<C-o><C-s>', { remap = true })
map('', '<C-s>', '<Cmd>set spell!<CR>', { remap = true })

-- Star search but stay at same word.
map('', '<C-n>', '*N', { remap = true })

-- Set undo breakpoints.
map('i', '!', '!<c-g>u')
map('i', '(', '(<c-g>u')
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '?', '?<c-g>u')
map('i', '[', '[<c-g>u')
map('i', '{', '{<c-g>u')

-- Search for selected text with DuckDuckGo.
map('v', 'K', '"oy<Esc><Cmd>Ddg<CR>')

-- Open file or URL with mimeo.
map(
  'n',
  'gx',
  '<Cmd>silent execute "!mimeo " . shellescape(expand(\'<cfile>\'))<CR>'
)
