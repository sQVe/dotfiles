--  ┏━┓┏━┓┏━╸╻┏ ┏━╸┏━┓
--  ┣━┛┣━┫┃  ┣┻┓┣╸ ┣┳┛
--  ╹  ╹ ╹┗━╸╹ ╹┗━╸╹┗╸
local fn = vim.fn

local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Bootstrap packer if it isn't installed.
if fn.empty(fn.glob(packer_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_path
    })
    vim.cmd('packadd packer.nvim')
end

vim.cmd [[ packadd packer.nvim ]]

-- https://github.com/datwaft/nvim/tree/master/lua/plugins
-- https://elianiva.my.id/post/improving-nvim-startup-time

return require('packer').startup(function(use)
    -- Handle packer with packer.
    use {'wbthomason/packer.nvim', opt = true}

    -- Editing.
    use {'tpope/vim-repeat', event = 'BufEnter'} -- Repeat for plugins.
    use {
        'machakann/vim-sandwich', -- Surround text.
        config = require('plugins.editing.sandwich'),
        event = 'CursorMoved'
    }
    use {
        'junegunn/vim-easy-align', -- Alignment.
        keys = "<Plug>(EasyAlign)"
    }

    -- Integration.
    use {'editorconfig/editorconfig-vim', event = 'BufEnter'} -- Editorconfig.
    use {
        'axelf4/vim-strip-trailing-whitespace',
        config = require('plugins.integration.strip-trailing-whitespace'),
        event = 'BufEnter'
    }

    -- Theme.
    use { -- Gruvbox color theme.
        "npxbr/gruvbox.nvim",
        config = require('plugins.theme.gruvbox'),
        requires = {"rktjmp/lush.nvim"}
    }
    use {
        'nvim-treesitter/nvim-treesitter', -- Treesitter highlighting.
        config = require('plugins.theme.treesitter'),
        event = "BufEnter",
        run = ':TSUpdate'
    }
    use {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'} -- Treesitter rainbow parentheses.

    --  Documentation.
    use {"tpope/vim-commentary", keys = {{'n', 'gc'}, {'v', 'gc'}}} -- Comment text.
    use {
        'kkoomen/vim-doge', -- Documentation generator.
        cmd = {'DogeGenerate'},
        config = require('plugins.documentation.doge'),
        run = ':call doge#install()'
    }

    -- Commands.
    use { -- Set pwd to root directory.
        'airblade/vim-rooter',
        cmd = {'Rooter', 'RooterToggle'},
        config = require('plugins.commands.rooter')

    }
    use {'lambdalisue/suda.vim', cmd = {'SudaRead', 'SudaWrite'}} -- Read and write with sudo.
    use {'moll/vim-bbye', cmd = {'Bdelete', 'Bwipeout'}} -- Delete buffers without closing window.
    use {
        'tpope/vim-eunuch', -- Unix helpers.
        cmd = {'Chmod', 'Delete', 'Mkdir', 'Move', 'Rename'}
    }

    -- Git.
    use {
        'tpope/vim-fugitive', -- Fugitive (git interface and helpers).
        config = require('plugins.git.fugitive'),
        event = 'VimEnter'
    }
    use {
        'lewis6991/gitsigns.nvim', -- Git gutter signs.
        config = require('plugins.git.gitsigns'),
        event = 'BufEnter',
        requires = {'nvim-lua/plenary.nvim'}
    }
    use {
        'shumphrey/fugitive-gitlab.vim', -- Fugitive GitLab support.
        after = {'vim-fugitive'},
        config = require('plugins.git.fugitive-gitlab')
    }
    use {'tpope/vim-rhubarb', after = {'vim-fugitive'}} -- Fugitive GitHub support.
    use {
        'whiteinge/diffconflicts', -- Git mergetool.
        cmd = {
            'DiffConflicts', 'DiffConflictsShowHistory',
            'DiffConflictsWithHistory '
        }
    }

    -- Interface.
    use {'ap/vim-buftabline', event = 'BufEnter'} -- Buffer line.
    use {
        'camspiers/lens.vim', -- Resize windows based on content.
        config = require('plugins.interface.lens'),
        event = 'WinEnter'
    }
    use {
        'itchyny/lightline.vim', -- Status line.
        config = require('plugins.interface.lightline')
    }
    use {
        'glepnir/dashboard-nvim', -- Dashboard.
        config = require('plugins.interface.dashboard'),
        event = 'VimEnter'
    }
    use {
        'voldikss/vim-floaterm', -- Floating terminal.
        cmd = {
            'FloatermFirst', 'FloatermHide', 'FloatermKill', 'FloatermLast',
            'FloatermNew', 'FloatermNext', 'FloatermPrev', 'FloatermSend',
            'FloatermShow', 'FloatermToggle', 'FloatermUpdate'
        },
        config = require('plugins.interface.floaterm')
    }

    -- LSP.
    use {
        'hrsh7th/nvim-compe', -- Completion.
        config = require('plugins.lsp.compe'),
        event = 'InsertEnter'
    }
    use {
        'neovim/nvim-lspconfig', -- Collection of configurations.
        after = 'lsp_signature.nvim',
        config = require('plugins.lsp')
    }
    use {
        'ojroques/nvim-lspfuzzy', -- Use fzf for LSP handlers.
        after = {'fzf.vim', 'nvim-lspconfig'},
        config = require('plugins.lsp.fuzzy')
    }
    use {
        'ray-x/lsp_signature.nvim', -- Signature help.
        event = "BufEnter",
        config = require('plugins.lsp.signature')
    }

    -- Override.
    use {'bronson/vim-visual-star-search', keys = {{'v', '*'}, {'v', '#'}}} -- Visual star search.
    use {
        'sickill/vim-pasta', -- Paste with smart indentation.
        config = require('plugins.override.pasta'),
        keys = {{'n', 'p'}, {'n', 'P'}, {'v', 'p'}, {'v', 'P'}}
    }
    use {'tpope/vim-speeddating', keys = {{'n', 'ctrl-a'}, {'n', 'ctrl-x'}}} -- Increment / decrement dates, times and more.
    use {'tversteeg/registers.nvim', keys = {{'n', '"'}, {'i', 'ctrl-r'}}} -- Interactive registers.

    -- Navigation.
    use {
        'junegunn/fzf.vim', -- Fzf.
        config = require('plugins.navigation.fzf'),
        event = 'VimEnter'
    }
    use {
        'justinmk/vim-sneak', -- Quick jump.
        config = require('plugins.navigation.sneak'),
        event = 'BufEnter'
    }
    use {
        'dyng/ctrlsf.vim', -- Search and replace over multiple files.
        cmd = {
            'CtrlSF', 'CtrlSFClearHL', 'CtrlSFClose', 'CtrlSFFocus',
            'CtrlSFOpen', 'CtrlSFQuickfix', 'CtrlSFStop', 'CtrlSFToggle',
            'CtrlSFUpdate'
        }
    }

    -- Snippets.
    use {
        'SirVer/ultisnips', -- Ultisnips.
        config = require('plugins.snippets.ultisnips'),
        event = 'InsertCharPre'
    }

    -- Text objects and motions.
    use {'christoomey/vim-sort-motion', keys = {{'n', 'gs'}, {'v', 'gs'}}} -- Sort by motion text object.
    use {'michaeljsmith/vim-indent-object', event = 'CursorMoved'} -- Indent text object.
    use {'wellle/targets.vim', event = 'CursorMoved'} -- Additional text objects.
end)