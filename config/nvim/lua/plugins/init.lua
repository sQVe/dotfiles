--  ┏━┓┏━┓┏━╸╻┏ ┏━╸┏━┓
--  ┣━┛┣━┫┃  ┣┻┓┣╸ ┣┳┛
--  ╹  ╹ ╹┗━╸╹ ╹┗━╸╹┗╸
local fn = vim.fn
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Bootstrap packer if it isn't installed.
if fn.empty(fn.glob(packer_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        packer_path,
    })
    vim.cmd('packadd packer.nvim')
end

return require('packer').startup(function(use)
    -- Handle packer with packer.
    use({'wbthomason/packer.nvim'})

    -- Editing.
    use({'tpope/vim-repeat', event = 'BufEnter'}) -- Repeat for plugins.
    use({
        'machakann/vim-sandwich', -- Surround text.
        config = require('plugins.editing.sandwich').config,
        event = 'BufEnter',
        setup = require('plugins.editing.sandwich').setup,
    })
    use({
        'junegunn/vim-easy-align', -- Alignment.
        cmd = {'EasyAlign'},
        config = require('plugins.editing.easy-align'),
        keys = {{'n', 'ga'}, {'x', 'ga'}},
    })

    -- Integration.
    use({'editorconfig/editorconfig-vim', event = 'BufEnter'}) -- Editorconfig.
    use({
        'michaelb/sniprun',
        run = 'bash ./install.sh',
        cmd = {'SnipRun'},
        config = require('plugins.integration.sniprun'),
    })

    -- Theme.
    use({ -- Gruvbox color theme.
        'npxbr/gruvbox.nvim',
        config = require('plugins.theme.gruvbox'),
        requires = {'rktjmp/lush.nvim'},
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
    use({ -- Comment text.
        'numToStr/Comment.nvim',
        config = require('plugins.documentation.comment'),
        keys = {{'n', 'gb'}, {'n', 'gc'}, {'v', 'gb'}, {'v', 'gc'}},
        requires = {'JoosepAlviste/nvim-ts-context-commentstring'},
    })
    use({ -- Automatically set commentstring.
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter',
    })
    use({
        'kkoomen/vim-doge', -- Documentation generator.
        cmd = {'DogeGenerate'},
        config = require('plugins.documentation.doge'),
        run = ':call doge#install()',
    })

    -- Commands.
    use({ -- Set pwd to root directory.
        'airblade/vim-rooter',
        cmd = {'Rooter', 'RooterToggle'},
        config = require('plugins.commands.rooter'),

    })
    use({'lambdalisue/suda.vim', cmd = {'SudaRead', 'SudaWrite'}}) -- Read and write with sudo.
    use({'moll/vim-bbye', cmd = {'Bdelete', 'Bwipeout'}}) -- Delete buffers without closing window.
    use({
        'tpope/vim-eunuch', -- Unix helpers.
        cmd = {'Chmod', 'Delete', 'Mkdir', 'Move', 'Rename'},
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
        requires = {'nvim-lua/plenary.nvim'},
    })
    use({
        'shumphrey/fugitive-gitlab.vim', -- Fugitive GitLab support.
        after = {'vim-fugitive'},
        config = require('plugins.git.fugitive-gitlab'),
    })
    use({'tpope/vim-rhubarb', after = {'vim-fugitive'}}) -- Fugitive GitHub support.
    use({
        'whiteinge/diffconflicts', -- Git mergetool.
        cmd = {
            'DiffConflicts', 'DiffConflictsShowHistory',
            'DiffConflictsWithHistory ',
        },
    })

    -- Interface.
    use({'ap/vim-buftabline', event = 'BufEnter'}) -- Buffer line.
    use({
        'beauwilliams/focus.nvim', -- Golden ratio window resizing.
        config = require('plugins.interface.focus'),
        event = 'BufEnter',
        module = 'focus',
    })
    use({ -- Zen Mode.
        'folke/zen-mode.nvim',
        cmd = {'ZenMode'},
        config = require('plugins.interface.zen-mode'),
    })
    use({
        'hoob3rt/lualine.nvim', -- Status line.
        config = require('plugins.interface.lualine'),
        event = 'BufEnter',
    })
    use({
        'glepnir/dashboard-nvim', -- Dashboard.
        config = require('plugins.interface.dashboard'),
        event = 'VimEnter',
    })
    use({
        'voldikss/vim-floaterm', -- Floating terminal.
        cmd = {
            'FloatermFirst', 'FloatermHide', 'FloatermKill', 'FloatermLast',
            'FloatermNew', 'FloatermNext', 'FloatermPrev', 'FloatermSend',
            'FloatermShow', 'FloatermToggle', 'FloatermUpdate',
        },
        config = require('plugins.interface.floaterm'),
        keys = {{'n', 'Ä'}, {'n', 'Å'}},
    })

    -- LSP.
    use({
        'jose-elias-alvarez/null-ls.nvim',
        after = 'nvim-lspconfig',
        config = require('plugins.lsp.null'),
        requires = {'nvim-lua/plenary.nvim'},
    })

    use({'jose-elias-alvarez/nvim-lsp-ts-utils', after = 'null-ls.nvim'})
    use({
        'neovim/nvim-lspconfig', -- Collection of configurations.
        after = {'cmp-nvim-lsp'},
        config = require('plugins.lsp'),
    })

    -- Completion.
    use({
        'hrsh7th/nvim-cmp', -- Completion engine.
        config = require('plugins.completion.cmp'),
        event = 'InsertEnter',
        requires = {'onsails/lspkind-nvim'},
    })
    use({'hrsh7th/cmp-buffer', after = 'nvim-cmp'}) -- Buffer completion.
    use({'hrsh7th/cmp-nvim-lsp', event = 'BufEnter'}) -- LSP completion.
    use({'hrsh7th/cmp-path', after = 'nvim-cmp'}) -- Path completion.
    use({'hrsh7th/cmp-vsnip', after = 'nvim-cmp'}) -- VSnip completion.
    use({
        'hrsh7th/vim-vsnip', -- Snippet support.
        after = 'nvim-cmp',
        setup = require('plugins.completion.vsnip'),
    })

    -- Override.
    use({'bronson/vim-visual-star-search', keys = {{'v', '*'}, {'v', '#'}}}) -- Visual star search.
    use({
        'sickill/vim-pasta', -- Paste with smart indentation.
        config = require('plugins.override.pasta'),
        keys = {{'n', 'p'}, {'n', 'P'}, {'v', 'p'}, {'v', 'P'}},
    })
    use({'tpope/vim-speeddating', keys = {{'n', '<c-a>'}, {'n', '<c-x>'}}}) -- Increment / decrement dates, times and more.
    use({ -- Interactive registers.
        'tversteeg/registers.nvim',
        event = 'BufEnter',
    })

    -- Navigation.
    use({
        'dyng/ctrlsf.vim', -- Search and replace over multiple files.
        cmd = {
            'CtrlSF', 'CtrlSFClearHL', 'CtrlSFClose', 'CtrlSFFocus',
            'CtrlSFOpen', 'CtrlSFQuickfix', 'CtrlSFStop', 'CtrlSFToggle',
            'CtrlSFUpdate',
        },
    })
    use({
        'ggandor/lightspeed.nvim', -- Quick jump.
        config = require('plugins.navigation.lightspeed'),
        after = 'vim-sandwich',
    })
    use({
        'nvim-telescope/telescope.nvim', -- Telescope.
        event = 'VimEnter',
        config = require('plugins.navigation.telescope').config,
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
        },
    })

    -- Text objects and motions.
    use({'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter'}) -- Smart selection.
    use({'michaeljsmith/vim-indent-object', event = 'CursorMoved'}) -- Indent text object.
    use({'wellle/targets.vim', event = 'CursorMoved'}) -- Additional text objects.
end)
