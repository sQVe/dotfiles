--  ┏━┓┏━┓┏━╸╻┏ ┏━╸┏━┓   ╻  ┏━┓┏━┓╺┳┓
--  ┣━┛┣━┫┃  ┣┻┓┣╸ ┣┳┛╺━╸┃  ┃ ┃┣━┫ ┃┃
--  ╹  ╹ ╹┗━╸╹ ╹┗━╸╹┗╸   ┗━╸┗━┛╹ ╹╺┻┛
local execute = vim.api.nvim_command
local fn = vim.fn

local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Bootstrap packer if it isn't installed.
if fn.empty(fn.glob(packer_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_path
    })
    execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    -- Handle packer via packer.
    use 'wbthomason/packer.nvim'

    -- Align, repeat and surround.
    use 'junegunn/vim-easy-align' -- Alignment.
    use 'tpope/vim-repeat' -- Repeat for plugins.
    use 'machakann/vim-sandwich' -- Surround text.

    -- Automatic integration.
    use 'axelf4/vim-strip-trailing-whitespace' -- Remove trailing whitespace.
    use 'editorconfig/editorconfig-vim' -- Editorconfig.

    -- Colorschemes, highlighting and syntax.
    use 'lifepillar/vim-gruvbox8' -- Speedy gruvbox theme.
    use 'sheerun/vim-polyglot' -- Language pack.
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- Treesitter highlighting.
    use {'p00f/nvim-ts-rainbow', requires = {'nvim-treesitter/nvim-treesitter'}} -- Treesitter rainbow parentheses.

    -- Comments and documentation.
    use {'kkoomen/vim-doge', run = ':call doge#install()'} -- Documentation generator.
    use 'tpope/vim-commentary' -- Comment text.

    -- Commands.
    use 'lambdalisue/suda.vim' -- Read and write with sudo.
    use { -- Set pwd to root directory.
        'airblade/vim-rooter',
        cmd = {'Rooter', 'RooterToggle'},
        opt = true
    }
    use {'moll/vim-bbye', cmd = {'Bdelete', 'Bwipeout'}, opt = true}
    use {
        'tpope/vim-eunuch',
        cmd = {
            'Cfind', 'Chmod', 'Clocate', 'Delete', 'Lfind', 'Llocate', 'Mkdir',
            'Move', 'Rename', 'SudoEdit', 'SudoWrite', 'Unlink', 'Wall'
        },
        opt = true
    }

    -- Git.
    use 'tpope/vim-fugitive' -- Git.
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}} -- Git gutter signs.
    use { -- Fugitive GitLab support.
        'shumphrey/fugitive-gitlab.vim',
        cmd = {'GBrowse'},
        opt = true,
        requires = {'tpope/vim-fugitive'}
    }
    use { -- Fugitive GitHub support.
        'tpope/vim-rhubarb',
        cmd = {'GBrowse'},
        opt = true,
        requires = {'tpope/vim-fugitive'}
    }
    use { -- Git mergetool
        'whiteinge/diffconflicts',
        cmd = {
            'DiffConflicts', 'DiffConflictsShowHistory',
            'DiffConflictsWithHistory '
        },
        opt = true
    }

    -- Interface.
    use 'ap/vim-buftabline' -- Buffer line.
    use 'camspiers/lens.vim' -- Resize windows based on content.
    use 'itchyny/lightline.vim' -- Status line.
    use 'mhinz/vim-startify' -- Launch screen.
    use { -- Floating terminal.
        'voldikss/vim-floaterm',
        cmd = {
            'FloatermFirst', 'FloatermHide', 'FloatermKill', 'FloatermLast',
            'FloatermNew', 'FloatermNext', 'FloatermPrev', 'FloatermSend',
            'FloatermShow', 'FloatermToggle', 'FloatermUpdate'
        },
        opt = true
    }

    -- LSP.
    use 'hrsh7th/nvim-compe' -- Completion.
    use 'neovim/nvim-lspconfig' -- Collection of configurations.
    use 'ojroques/nvim-lspfuzzy' -- Use fzf for LSP handlers.

    use 'ray-x/lsp_signature.nvim' -- Signature help.

    -- Override defaults.
    use 'bronson/vim-visual-star-search' -- Visual star search.
    use 'sickill/vim-pasta' -- Paste with smart indentation.
    use 'tpope/vim-speeddating' -- Increment / decrement dates, times and more.
    use 'tversteeg/registers.nvim' -- Interactive registers.

    -- Search, replace and navigation.
    use 'justinmk/vim-sneak' -- Quick jump.
    use { -- Search and replace over multiple files.
        'dyng/ctrlsf.vim',
        cmd = {
            'CtrlSF', 'CtrlSFClearHL', 'CtrlSFClose', 'CtrlSFFocus',
            'CtrlSFOpen', 'CtrlSFQuickfix', 'CtrlSFStop', 'CtrlSFToggle',
            'CtrlSFUpdate'

        },
        opt = true
    }
    use { -- Fzf.
        'junegunn/fzf.vim',
        cmd = {
            'Files', 'GFiles', 'Buffers', 'Rg', 'Marks', 'Commits', 'BCommits',
            'Commands'
        },
        opt = true
    }

    -- Snippets.
    use 'SirVer/ultisnips'

    -- Text objects and motions.
    use 'christoomey/vim-sort-motion' -- Sort by motion text object.
    use 'michaeljsmith/vim-indent-object' -- Indent text object.
    use 'wellle/targets.vim' -- Additional text objects.
end)
