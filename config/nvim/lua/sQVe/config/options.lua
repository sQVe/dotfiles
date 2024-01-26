-- ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
-- ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

local character = {
  -- Configure fill characters for various UI elements.
  fillchars = vim.opt.fillchars + {
    diff = '╱', -- Character for vertical separators in diff mode.
    eob = ' ',
    fold = ' ',
    foldclose = '',
    foldopen = '',
    foldsep = ' ',
    msgsep = '─',
  },

  -- Show characters listed in 'listchars' for better text visibility.
  list = true,
  listchars = {
    extends = '›', -- Character indicating a line continues to the right.
    nbsp = '•', -- Character indicating a non-breaking space.
    precedes = '‹', -- Character indicating a line continues to the left.
    tab = '→ ', -- Character indicating a TAB character.
    trail = '•', -- Character indicating trailing spaces.
  },

  -- Set the character to indicate wrapped lines.
  showbreak = '↲ ',
}

local completion = {
  -- Set completion menu options for better usability.
  completeopt = { 'menuone', 'noselect', 'noinsert' },

  -- Make the completion menu slightly transparent.
  pumblend = 10,

  -- Limit the completion menu to a maximum of 20 items.
  pumheight = 20,

  -- Limit the completion menu to a maximum of 20 characters.
  pumwidth = 20,

  -- Ignore case when using the wildmenu for file name completion.
  wildignorecase = true,

  -- Set wildmenu completion modes for efficient command line completion.
  wildmode = { 'longest:full', 'full' },
}

local fold = {
  -- Show fold column.
  foldcolumn = '1',

  -- Start with all folds open by default.
  foldlevelstart = 99,

  -- Set minimum lines for folds.
  foldminlines = 4,

  -- Set maximum nesting level for folds.
  foldnestmax = 8,

  -- Use treesitter based folding.
  foldmethod = 'expr',
  foldexpr = 'v:lua.vim.treesitter.foldexpr()',
  foldtext = 'v:lua.vim.treesitter.foldtext()',
}

local indent = {
  -- Align wrapped lines with the start of the line.
  breakindent = true,

  -- Use spaces instead of TAB characters when indentin.
  expandtab = true,

  -- Avoid inserting double spaces after punctuation when joining lines with
  -- the 'J' mapping.
  joinspaces = false,

  -- Wrap long lines at characters specified in 'breakat'.
  linebreak = true,

  -- Round indentations to the nearest multiple of 'shiftwidth'.
  shiftround = true,

  -- Set the number of spaces for each indentation level when using the < and >
  -- mappings.
  shiftwidth = 2,

  -- Display TAB characters using the specified number of spaces for visual
  -- alignment.
  tabstop = 2,
}

local misc = {
  -- Allow clipboard register for yank and paste operations.
  clipboard = 'unnamedplus',

  -- Never conceal any characters.
  conceallevel = 0,

  -- Prompt to save changes on quitting Neovim.
  confirm = true,

  -- Enhance diff alignment with second stage diff on each hunk.
  diffopt = vim.opt.diffopt + { 'linematch:60' },

  -- Permit sourcing local vimrc files in project root directories.
  exrc = true,

  -- Maintain 8 lines context when scrolling.
  scrolloff = 8,

  -- Columns of content.
  sidescrolloff = 4,

  -- Refine "hit enter" prompts for cleaner message area.
  shortmess = vim.opt.shortmess + {
    I = true, -- Suppress intro message when starting Neovim.
    S = true, -- Suppress "search hit BOTTOM, continuing at TOP" message.
    W = true, -- Suppress "written" message on file write.
    c = true, -- Suppress completion menu messages.
  },

  -- Show matching brackets when cursor is over them.
  showmatch = true,

  -- Avoid mode messages in the command line.
  showmode = false,

  -- Support file lookup for specified file extensions.
  suffixesadd = {
    '.css',
    '.html',
    '.js',
    '.json',
    '.jsx',
    '.lua',
    '.md',
    '.rs',
    '.scss',
    '.sh',
    '.ts',
    '.tsx',
    '.yaml',
    '.yml',
  },

  -- Allow ~ operator to change case of characters.
  tildeop = true,

  -- Enable flexible cursor movement in Visual Block mode.
  virtualedit = 'block',
}

local mouse = {
  -- Enable mouse support across all modes.
  mouse = 'a',

  -- Use the "extend" mouse model to extend text selection using the right
  -- button.
  mousemodel = 'extend',

  -- Disable horizontal scrolling.
  mousescroll = 'ver:3,hor:0',
}

local program = {
  -- Configure the format for grep results.
  grepformat = '%f:%l:%c:%m,%f:%l:%m',

  -- Set the grep program to use with Neovim.
  grepprg = 'rg --vimgrep --no-heading',
}

local search_and_substitute = {
  -- Use 'g' flag by default in :s/foo/bar/ for global search and replace.
  gdefault = true,

  -- Enforce case sensitivity for search patterns.
  ignorecase = false,

  -- Enable incremental highlighting for Ex commands without window split.
  inccommand = 'nosplit',

  -- Disable smart case, which enables case-insensitive search when the pattern
  -- is all lowercase.
  smartcase = false,
}

local spell = {
  -- Set the system dictionary.
  dictionary = vim.o.dictionary .. '/usr/share/dict/words',

  -- Set the language for spell checking.
  spelllang = 'en_us',

  -- Set the options for spell checking, such as camel case sensitivity.
  spelloptions = 'camel',

  -- Set the user-specific spellfile.
  spellfile = vim.fn.expand('$XDG_CONFIG_HOME') .. '/nvim/spell/en.utf-8.add',
}

local split = {
  -- Keep the text cursor in the same position when opening a new horizontal
  -- split.
  splitkeep = 'screen',

  -- Place new horizontal splits below the current window.
  splitbelow = true,

  -- Place new vertical splits to the right of the current window.
  splitright = true,
}

local timeout = {
  -- Set Leader key timeout to 300 ms.
  timeoutlen = 300,

  -- Wait 10 ms for key sequences.
  ttimeoutlen = 10,

  -- Set buffer update time to 150 ms.
  updatetime = 150,
}

local ui = {
  -- Display a colored indicator at column 80.
  colorcolumn = '80',

  -- Highlight the line containing the cursor.
  cursorline = true,

  -- Show absolute line numbers by default.
  number = true,

  -- Ensure the statusline is always visible for all windows.
  laststatus = 3,

  -- Keep the sign column visible at all times for a consistent window layout.
  signcolumn = 'yes',

  -- Enable 24-bit color support in terminal.
  termguicolors = true,
}

local undo = {
  -- Enable persistent undo history across Neovim sessions.
  undofile = true,

  -- Disable backup files and set temporary directories.
  -- This avoids cluttering the working directory with backup and swap files.
  backup = false,
  swapfile = false,
  writebackup = false,
  backupdir = '/tmp',
  directory = '/tmp',
}

-- Apply the options settings.
for option, value in
  pairs(
    vim.tbl_extend(
      'error',
      misc,
      search_and_substitute,
      character,
      completion,
      program,
      fold,
      indent,
      mouse,
      spell,
      split,
      ui,
      timeout,
      undo
    )
  )
do
  vim.opt[option] = value
end

-- Set the <Space> key as the Leader key.
vim.g.mapleader = ' '
