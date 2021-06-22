--  ┏━┓┏━┓┏━╸╻┏ ┏━╸┏━┓   ╻  ┏━┓┏━┓╺┳┓
--  ┣━┛┣━┫┃  ┣┻┓┣╸ ┣┳┛╺━╸┃  ┃ ┃┣━┫ ┃┃
--  ╹  ╹ ╹┗━╸╹ ╹┗━╸╹┗╸   ┗━╸┗━┛╹ ╹╺┻┛
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

    -- Align, repeat and surround.
    use {'tpope/vim-repeat', event = 'BufEnter'} -- Repeat for plugins.
    use {'machakann/vim-sandwich', event = 'CursorMoved'} -- Surround text.
    use {
        'junegunn/vim-easy-align', -- Alignment.
        keys = "<Plug>(EasyAlign)"
    }

    -- Automatic integration.
    use {'editorconfig/editorconfig-vim', event = 'BufEnter'} -- Editorconfig.

    -- Colorschemes, highlighting and syntax.
    use { -- Gruvbox color theme.
        "npxbr/gruvbox.nvim",
        config = require('plugins.theme'),
        requires = {"rktjmp/lush.nvim"}
    }
    use {'sheerun/vim-polyglot', event = 'BufEnter'} -- Language pack.
    use {
        'nvim-treesitter/nvim-treesitter', -- Treesitter highlighting.
        config = function() require('plugins.treesitter') end,
        event = "BufEnter",
        run = ':TSUpdate'
    }
    use {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'} -- Treesitter rainbow parentheses.

    -- Comments and documentation.
    use {"tpope/vim-commentary", keys = {{'n', 'gc'}, {'v', 'gc'}}} -- Comment text.
    use {
        'kkoomen/vim-doge', -- Documentation generator.
        cmd = {'DogeGenerate'},
        run = ':call doge#install()'
    }

    -- Commands.
    use {'airblade/vim-rooter', cmd = {'Rooter', 'RooterToggle'}} -- Set pwd to root directory.
    use {'lambdalisue/suda.vim', cmd = {'SudaRead', 'SudaWrite'}} -- Read and write with sudo.
    use {'moll/vim-bbye', cmd = {'Bdelete', 'Bwipeout'}} -- Delete buffers without closing window.
    use {
        'tpope/vim-eunuch', -- Unix helpers.
        cmd = {'Chmod', 'Delete', 'Mkdir', 'Move', 'Rename'}
    }

    -- Git.
    use {'tpope/vim-fugitive', event = 'VimEnter'} -- Fugitive (git interface and helpers).
    use {
        'lewis6991/gitsigns.nvim', -- Git gutter signs.
        config = require('plugins.gitsigns'),
        event = 'BufEnter',
        requires = {'nvim-lua/plenary.nvim'}
    }
    use {
        'shumphrey/fugitive-gitlab.vim', -- Fugitive GitLab support.
        cmd = {'GBrowse'},
        requires = {'tpope/vim-fugitive'}
    }
    use {
        'tpope/vim-rhubarb', -- Fugitive GitHub support.
        cmd = {'GBrowse'},
        requires = {'tpope/vim-fugitive'}
    }
    use {
        'whiteinge/diffconflicts', -- Git mergetool.
        cmd = {
            'DiffConflicts', 'DiffConflictsShowHistory',
            'DiffConflictsWithHistory '
        }
    }

    -- Interface.
    use {'ap/vim-buftabline', event = 'BufEnter'} -- Buffer line.
    use {'camspiers/lens.vim', event = 'WinEnter'} -- Resize windows based on content.
    use {
        'itchyny/lightline.vim', -- Status line.
        config = function()
            vim.g.lightline = {
                active = {
                    left = {
                        {'mode', 'paste'}, {'gitbranch'},
                        {'filename', 'readonly'}
                    },
                    right = {{'lineinfo'}, {'percent'}, {'filetype'}}
                },
                colorscheme = 'gruvbox',
                component_function = {
                    filename = 'LightlineFilename',
                    gitbranch = 'fugitive#head'
                },
                enable = {tabline = 0},
                mode_map = {
                    n = 'N',
                    i = 'I',
                    R = 'R',
                    v = 'V',
                    c = 'C',
                    V = 'VL',
                    ["<C-v>"] = 'VB'
                }
            }
        end
    }
    use {
        'glepnir/dashboard-nvim', -- Dashboard.
        config = require('plugins.dashboard'),
        event = 'VimEnter'
    }
    use {
        'voldikss/vim-floaterm', -- Floating terminal.
        cmd = {
            'FloatermFirst', 'FloatermHide', 'FloatermKill', 'FloatermLast',
            'FloatermNew', 'FloatermNext', 'FloatermPrev', 'FloatermSend',
            'FloatermShow', 'FloatermToggle', 'FloatermUpdate'
        }
    }

    -- LSP.
    use {
        'hrsh7th/nvim-compe', -- Completion.
        config = function() require('plugins.lsp.compe') end,
        event = 'InsertEnter'
    }
    use {
        'neovim/nvim-lspconfig', -- Collection of configurations.
        after = 'lsp_signature.nvim',
        config = function() require('plugins.lsp') end
    }
    use {
        'ojroques/nvim-lspfuzzy', -- Use fzf for LSP handlers.
        after = {'fzf.vim', 'nvim-lspconfig'},
        config = function() require('plugins.lsp.fuzzy') end
    }
    use {
        'ray-x/lsp_signature.nvim', -- Signature help.
        event = "BufEnter",
        config = function() require('plugins.lsp.signature') end
    }

    -- Override defaults.
    use {'bronson/vim-visual-star-search', keys = {{'v', '*'}, {'v', '#'}}} -- Visual star search.
    use {
        'sickill/vim-pasta', -- Paste with smart indentation.
        keys = {{'n', 'p'}, {'n', 'P'}, {'v', 'p'}, {'v', 'P'}}
    }
    use {'tpope/vim-speeddating', keys = {{'n', 'ctrl-a'}, {'n', 'ctrl-x'}}} -- Increment / decrement dates, times and more.
    use {'tversteeg/registers.nvim', keys = {{'n', '"'}, {'i', 'ctrl-r'}}} -- Interactive registers.

    -- Search, replace and navigation.
    use {'junegunn/fzf.vim', event = 'VimEnter'} -- Fzf.
    use {'justinmk/vim-sneak', event = 'BufEnter'} -- Quick jump.
    use {
        'dyng/ctrlsf.vim', -- Search and replace over multiple files.
        cmd = {
            'CtrlSF', 'CtrlSFClearHL', 'CtrlSFClose', 'CtrlSFFocus',
            'CtrlSFOpen', 'CtrlSFQuickfix', 'CtrlSFStop', 'CtrlSFToggle',
            'CtrlSFUpdate'
        }
    }

    -- Snippets.
    use {'SirVer/ultisnips', event = 'InsertCharPre'}

    -- Text objects and motions.
    use {'christoomey/vim-sort-motion', keys = {{'n', 'gs'}, {'v', 'gs'}}} -- Sort by motion text object.
    use {'michaeljsmith/vim-indent-object', event = 'CursorMoved'} -- Indent text object.
    use {'wellle/targets.vim', event = 'CursorMoved'} -- Additional text objects.
end)
