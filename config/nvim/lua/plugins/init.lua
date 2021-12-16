-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

-- Add builtin plugins.
vim.cmd('packadd cfilter')

return require('packer').startup(function(use)
  -- Handle packer with packer.
  use({ 'wbthomason/packer.nvim', opt = true })

  -- Optimize startup.
  use({ 'lewis6991/impatient.nvim' })

  -- Editing.
  use({
    'gabrielpoca/replacer.nvim', -- Search and replace over quicklist.
    cmd = { 'Replace', 'ReplaceContent' },
    config = require('plugins.editing.replacer'),
  })
  use({
    'machakann/vim-sandwich', -- Surround text.
    config = require('plugins.editing.sandwich').config,
    event = 'BufEnter',
    setup = require('plugins.editing.sandwich').setup,
  })
  use({
    'junegunn/vim-easy-align', -- Alignment.
    cmd = { 'EasyAlign' },
    config = require('plugins.editing.easy-align'),
    keys = { { 'n', 'ga' }, { 'x', 'ga' } },
  })
  use({ 'tpope/vim-repeat', event = 'BufEnter' }) -- Repeat for plugins.

  -- Integration.
  use({ 'editorconfig/editorconfig-vim', event = 'BufEnter' }) -- Editorconfig.
  use({
    'michaelb/sniprun', -- Run blocks of code.
    run = 'bash ./install.sh',
    cmd = { 'SnipRun' },
    config = require('plugins.integration.sniprun'),
  })

  -- Theme.
  use({
    'npxbr/gruvbox.nvim', -- Gruvbox color theme.
    config = require('plugins.theme.gruvbox'),
    requires = { 'rktjmp/lush.nvim' },
  })
  use({
    'lukas-reineke/indent-blankline.nvim', -- Indent Guides.
    after = 'nvim-treesitter',
    setup = require('plugins.theme.indent-blankline'),
  })

  -- Syntax.
  use({
    'nvim-treesitter/nvim-treesitter', -- Treesitter highlighting.
    config = require('plugins.syntax.treesitter'),
    event = 'BufEnter',
    run = ':TSUpdate',
  })

  --  Documentation.
  use({
    'numToStr/Comment.nvim', -- Comment text.
    config = require('plugins.documentation.comment'),
    keys = { { 'n', 'gb' }, { 'n', 'gc' }, { 'v', 'gb' }, { 'v', 'gc' } },
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  })
  use({
    'JoosepAlviste/nvim-ts-context-commentstring', -- Automatically set commentstring.
    after = 'nvim-treesitter',
  })
  use({
    'kkoomen/vim-doge', -- Documentation generator.
    cmd = { 'DogeGenerate' },
    config = require('plugins.documentation.doge'),
    run = ':call doge#install()',
  })

  -- Commands.
  use({
    'ahmedkhalf/project.nvim', -- Set pwd to root directory.
    cmd = { 'ProjectRoot' },
    config = require('plugins.commands.project'),
  })
  use({ 'lambdalisue/suda.vim', cmd = { 'SudaRead', 'SudaWrite' } }) -- Read and write with sudo.
  use({ 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } }) -- Delete buffers without closing window.
  use({
    'tpope/vim-eunuch', -- Unix helpers.
    cmd = { 'Chmod', 'Delete', 'Mkdir', 'Move', 'Rename' },
  })
  use({
    'sQVe/sort.nvim', -- Sort by line and delimiter.
    cmd = { 'Sort' },
    config = require('plugins.commands.sort'),
    keys = { { 'n', 'go' }, { 'v', 'go' } },
  })

  -- Git.
  use({
    'tpope/vim-fugitive', -- Fugitive (git interface and helpers).
    config = require('plugins.git.fugitive'),
    event = 'VimEnter',
  })
  use({
    'lewis6991/gitsigns.nvim', -- Git gutter signs.
    config = require('plugins.git.gitsigns'),
    event = 'BufEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({
    'shumphrey/fugitive-gitlab.vim', -- Fugitive GitLab support.
    after = { 'vim-fugitive' },
    config = require('plugins.git.fugitive-gitlab'),
  })
  use({ 'tpope/vim-rhubarb', after = { 'vim-fugitive' } }) -- Fugitive GitHub support.
  use({
    'whiteinge/diffconflicts', -- Git mergetool.
    cmd = {
      'DiffConflicts',
      'DiffConflictsShowHistory',
      'DiffConflictsWithHistory ',
    },
  })

  -- Interface.
  use({
    'ThePrimeagen/harpoon', -- Keep and list WIP buffers.
    config = require('plugins.interface.harpoon'),
    event = 'VimEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({
    'beauwilliams/focus.nvim', -- Golden ratio window resizing.
    config = require('plugins.interface.focus'),
    event = 'BufEnter',
    module = 'focus',
  })
  use({
    'filipdutescu/renamer.nvim', -- Rename UI.
    config = require('plugins.interface.renamer'),
    keys = { { 'n', '<Leader>r' } },
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({
    'folke/zen-mode.nvim', -- Zen Mode.
    cmd = { 'ZenMode' },
    config = require('plugins.interface.zen-mode'),
  })
  use({
    'nvim-lualine/lualine.nvim', -- Status line.
    config = require('plugins.interface.lualine'),
    event = 'BufEnter',
  })
  use({
    'goolord/alpha-nvim', -- Dashboard.
    config = require('plugins.interface.alpha'),
    event = 'VimEnter',
  })
  use({
    'is0n/fm-nvim', -- File manager.
    cmd = { 'Fzf', 'Vifm' },
    config = require('plugins.interface.fm'),
    keys = { { 'n', 'Ä' }, { 'n', 'Å' } },
  })

  -- LSP.
  use({
    'jose-elias-alvarez/null-ls.nvim', -- Format and linting LSP.
    config = require('plugins.lsp.null'),
    event = 'BufEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({
    'neovim/nvim-lspconfig', -- Collection of configurations.
    config = require('plugins.lsp'),
    event = { 'BufEnter' },
  })

  -- Completion.
  use({
    'hrsh7th/nvim-cmp', -- Completion engine.
    config = require('plugins.completion.cmp'),
    event = { 'CmdlineEnter', 'InsertEnter' },
    requires = { 'onsails/lspkind-nvim' },
  })
  use({ 'hrsh7th/cmp-buffer', after = 'cmp-path' }) -- Buffer completion.
  use({ 'hrsh7th/cmp-cmdline', after = 'cmp-nvim-lsp' }) -- Command completion.
  use({ 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' }) -- LSP completion.
  use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }) -- API completion.
  use({ 'hrsh7th/cmp-path', after = 'cmp-cmdline' }) -- Path completion.
  use({ 'hrsh7th/cmp-vsnip', after = 'cmp-buffer' }) -- VSnip completion.
  use({
    'hrsh7th/vim-vsnip', -- Snippet support.
    after = 'cmp-vsnip',
    setup = require('plugins.completion.vsnip'),
  })

  -- Override.
  use({
    'bronson/vim-visual-star-search', -- Visual star search.
    keys = { { 'v', '*' }, { 'v', '#' } },
  })
  use({
    'sickill/vim-pasta', -- Paste with smart indentation.
    config = require('plugins.override.pasta'),
    event = 'BufEnter',
  })
  use({
    'tpope/vim-speeddating', -- Increment / decrement dates, times and more.
    keys = { { 'n', '<c-a>' }, { 'n', '<c-x>' } },
  })
  use({
    'tversteeg/registers.nvim', -- Interactive registers.
    keys = { { 'i', '<c-r>' }, { 'n', '"' }, { 'v', '"' } },
  })

  -- Navigation.
  use({
    'ggandor/lightspeed.nvim', -- Quick jump.
    config = require('plugins.navigation.lightspeed'),
    after = 'vim-sandwich',
  })
  use({
    'nvim-telescope/telescope.nvim', -- Telescope.
    config = require('plugins.navigation.telescope').config,
    event = 'BufEnter',
    requires = {
      'ThePrimeagen/git-worktree.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  })

  -- Text objects and motions.
  use({ 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter' }) -- Smart selection.
  use({ 'michaeljsmith/vim-indent-object', event = 'CursorMoved' }) -- Indent text object.
  use({ 'wellle/targets.vim', event = 'CursorMoved' }) -- Additional text objects.
end)
