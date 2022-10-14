-- ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
-- ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

-- stylua: ignore
local options = {
  clipboard = 'unnamedplus',                        -- Use the + (clipboard) register.
  conceallevel = 0,                                 -- Disable conceal.
  exrc = true,                                      -- Source local vimrc at root directory.
  gdefault = true,                                  -- Use 'g' flag by default with :s/foo/bar/.
  lazyredraw = true,                                -- Enable lazy redraw.
  mouse = 'a',                                      -- Enable mouse.
  scrolloff = 8,                                    -- Set scroll offset to 8 lines.
  shortmess =
    vim.opt.shortmess  + { I = true, c = true },    -- Disable version intro text.
  showmode = false,                                 -- Disable show mode.
  suffixesadd = {                                   -- File extension lookup when going to file.
    '.css',
    '.go',
    '.html',
    '.js',
    '.json',
    '.jsx',
    '.lua',
    '.md',
    '.scss',
    '.sh',
    '.ts',
    '.tsx',
    '.yaml',
    '.yml',
  },
  termguicolors = true,                             -- Enable 24-bit colors.
  tildeop = true,                                   -- Enable ~ operator.
  virtualedit = 'block',                            -- Enable virtualedit when in Visual Block mode.

  -- Case.
  ignorecase = false,                               -- Enforce correct case.
  smartcase = false,                                -- Disable smart case.

  -- Columns, lines and numbering.
  colorcolumn = '80',                               -- Indicate column 80 with a colored column.
  cursorline = true,                                -- Show cursor line.
  number = true,                                    -- Show the line numbers on the left side.
  relativenumber = true,                            -- Relative line numbers.
  signcolumn = 'yes',                               -- Always show sign column.

  -- Completion.
  completeopt = { 'menu','menuone', 'noselect' },   -- Set compete options.
  pumheight = 20,                                   -- Show max 20 items in completion menu.
  wildignorecase = true,                            -- Disable case check for wildmenu.
  wildmode = 'longest:full',                        -- Set wildmenu modes.

  -- Disable backups.
  backup = false,
  backupdir = '/tmp',
  directory = '/tmp',
  swapfile = false,
  writebackup = false,

  -- Folding.
  foldenable = true,                                -- Enable folding.
  foldmethod='indent',                              -- Fold based on indention.
  foldnestmax = 4,                                  -- Folding max.
  foldlevelstart = 9999,                            -- Folding level.
  foldtext = [[substitute(getline(v:foldstart), '\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))]],

  -- Programs.
  grepformat = '%f:%l:%c:%m,%f:%l:%m',
  grepprg = 'rg --vimgrep --no-heading',

  -- Searching.
  inccommand = 'nosplit',                           -- Highlight patterns and ranges for Ex commands.
  showmatch = true,                                 -- Show matching brackets.

  -- Spelling.
  dictionary = vim.o.dictionary .. '/usr/share/dict/words',
  spellfile = vim.fn.expand('$XDG_CONFIG_HOME')
    .. '/nvim/spell/en.utf-8.add',
  spelllang = 'en_us',
  spelloptions = 'camel',

  -- Status and winbar.
  laststatus = 3,
  winbar = "%{%v:lua.require('sQVe.utils.options').get_winbar_layout()%}",

  -- Tabs and spaces.
  expandtab = true,                                 -- Insert spaces when TAB is pressed.
  joinspaces = false,                               -- Prevents inserting two spaces after punctuation on a join (J).
  shiftwidth = 2,                                   -- Indentation amount for < and > commands.
  tabstop = 2,                                      -- Render Tabs using this many spaces.

  -- Timings.
  timeoutlen = 400,                                 -- Timeout Leader after 400 ms.
  updatetime = 100,                                 -- Set update time to 100 ms.

  -- Undo.
  undofile = true,                                  -- Keep a persistent backup file.

  -- Whitespace.
  fillchars = vim.opt.fillchars + {                 -- Set fill chars.
   diff = '╱',
   fold = [[-]]
  },
  list = true,                                      -- Show characters listed in 'listchars'.
  listchars = {
    extends = '›',
    precedes = '‹',
    tab = '→ ',
    nbsp = '•',
    trail = '•',
  },
  showbreak = '↲ ',                                 -- Set show break character.

  -- Windows.
  splitbelow = true,                                -- Horizontal split below current.
  splitright = true,                                -- Vertical split to right of current.
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Use <Space> as Leader key.
vim.g.mapleader = ' '
