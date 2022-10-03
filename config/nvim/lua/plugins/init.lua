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
  use({ -- Surround text.
    'kylechui/nvim-surround',
    config = require('plugins.surround'),
    event = 'BufEnter',
  })
  use({
    'junegunn/vim-easy-align', -- Alignment.
    cmd = { 'EasyAlign' },
    config = require('plugins.easy-align'),
    keys = { { 'n', 'ga' }, { 'x', 'ga' } },
  })
  use({ 'tpope/vim-repeat', event = 'BufEnter' }) -- Repeat for plugins.

  -- Integration.
  use({ 'gpanders/editorconfig.nvim', event = 'BufEnter' }) -- Editorconfig.

  -- Theme.
  use({
    'npxbr/gruvbox.nvim', -- Gruvbox color theme.
    config = require('plugins.gruvbox'),
  })
  use({
    'lukas-reineke/indent-blankline.nvim', -- Indent Guides.
    after = 'nvim-treesitter',
    setup = require('plugins.indent-blankline'),
  })

  -- Syntax.
  use({
    'nvim-treesitter/nvim-treesitter', -- Treesitter highlighting.
    config = require('plugins.treesitter'),
    event = 'BufEnter',
    run = ':TSUpdate',
  })

  --  Documentation.
  use({
    'numToStr/Comment.nvim', -- Comment text.
    config = require('plugins.comment'),
    keys = { { 'n', 'gb' }, { 'n', 'gc' }, { 'v', 'gb' }, { 'v', 'gc' } },
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  })
  use({
    'JoosepAlviste/nvim-ts-context-commentstring', -- Automatically set commentstring.
    after = 'nvim-treesitter',
  })

  -- Commands.
  use({
    'ahmedkhalf/project.nvim', -- Set pwd to root directory.
    cmd = { 'ProjectRoot' },
    config = require('plugins.project'),
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
    config = require('plugins.sort'),
    keys = { { 'n', 'go' }, { 'v', 'go' } },
  })

  -- Git.
  use({
    'tpope/vim-fugitive', -- Fugitive (git interface and helpers).
    config = require('plugins.fugitive'),
    event = 'VimEnter',
  })
  use({
    'lewis6991/gitsigns.nvim', -- Git gutter signs.
    config = require('plugins.gitsigns'),
    event = 'BufEnter',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({
    'shumphrey/fugitive-gitlab.vim', -- Fugitive GitLab support.
    after = { 'vim-fugitive' },
    config = require('plugins.fugitive.gitlab'),
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
    'beauwilliams/focus.nvim', -- Golden ratio window resizing.
    config = require('plugins.focus'),
    event = 'BufEnter',
    module = 'focus',
  })
  use({
    'nvim-lualine/lualine.nvim', -- Status line.
    config = require('plugins.lualine'),
    event = 'BufEnter',
  })
  use({
    'goolord/alpha-nvim', -- Dashboard.
    config = require('plugins.alpha'),
    event = 'VimEnter',
  })
  use({
    'is0n/fm-nvim', -- File manager.
    cmd = { 'Fzf', 'Vifm' },
    config = require('plugins.fm'),
    keys = { { 'n', 'Ä' }, { 'n', 'Å' } },
  })

  -- LSP.
  use({
    'jose-elias-alvarez/null-ls.nvim', -- Format and linting LSP.
    after = 'nvim-lspconfig',
    config = require('plugins.lsp.null'),
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
    config = require('plugins.cmp'),
    event = { 'CmdlineEnter', 'InsertEnter' },
    requires = { 'onsails/lspkind-nvim' },
  })
  use({ 'hrsh7th/cmp-buffer', after = 'cmp-path' }) -- Buffer completion.
  use({ 'hrsh7th/cmp-cmdline', after = 'cmp-nvim-lsp' }) -- Command completion.
  use({ 'hrsh7th/cmp-emoji', after = 'cmp-vsnip' }) -- Emoji completion.
  use({ 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' }) -- LSP completion.
  use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }) -- API completion.
  use({ 'hrsh7th/cmp-path', after = 'cmp-cmdline' }) -- Path completion.
  use({ 'hrsh7th/cmp-vsnip', after = 'cmp-buffer' }) -- VSnip completion.
  use({
    'hrsh7th/vim-vsnip', -- Snippet support.
    after = 'cmp-vsnip',
    setup = require('plugins.vsnip'),
  })
  use({
    'windwp/nvim-autopairs', -- Complete pairs.
    event = { 'InsertEnter' },
    config = require('plugins.autopairs'),
  })

  -- Override.
  use({
    'sickill/vim-pasta', -- Paste with smart indentation.
    config = require('plugins.pasta'),
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
    'ggandor/leap.nvim', -- Quick jump.
    config = require('plugins.leap'),
    after = 'vim-repeat',
  })

  use({
    'nvim-telescope/telescope.nvim', -- Telescope.
    config = require('plugins.telescope').config,
    event = 'BufEnter',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  })

  -- Text objects and motions.
  use({ 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter' }) -- Smart selection.
  use({ 'michaeljsmith/vim-indent-object', event = 'CursorMoved' }) -- Indent text object.
  use({ 'wellle/targets.vim', event = 'CursorMoved' }) -- Additional text objects.
end)
