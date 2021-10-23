-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸
local M = {}

M.find_files = function(use_buffer_cwd)
    local builtin = require('telescope.builtin')
    local utils = require('telescope.utils')
    local opts = {follow = true, hidden = true, use_git_root = false}

    if use_buffer_cwd then
        opts.cwd = utils.buffer_dir()
    end

    local ok = pcall(builtin.git_files, opts)
    if not ok then
        builtin.find_files(opts)
    end
end

M.config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
        defaults = {
            dynamic_preview_title = true,
            layout_strategy = 'flex',
            layout_config = {
                height = 0.8,
                prompt_position = 'top',
                width = 0.8,
                flex = {flip_columns = 280},
                horizontal = {preview_width = 80},
                vertical = {preview_height = 0.25},
            },
            mappings = {
                i = {
                    ['<C-Down>'] = actions.cycle_history_next,
                    ['<C-Up>'] = actions.cycle_history_prev,
                    ['<C-s>'] = actions.select_horizontal,
                    ['<esc>'] = actions.close,
                    ['<Leader>q'] = actions.close,
                },
            },
            scroll_strategy = 'limit',
            sorting_strategy = 'ascending',
            vimgrep_arguments = {
                {
                    'rg', '--color=never', '--column', '--hidden',
                    '--line-number', '--no-heading', '--with-filename',
                },
            },
        },
    }

    -- Use fzf native.
    telescope.load_extension('fzf')

    vim.cmd([[
        " Telescope.
        nnoremap <silent> - :Telescope<CR>
        nnoremap <silent> _ :Telescope resume<CR>

        " Files and buffers.
        nnoremap <silent> <Backspace> :Telescope buffers<CR>
        nnoremap <silent> ä :lua require("plugins.navigation.telescope").find_files()<CR>
        nnoremap <silent> å :lua require("plugins.navigation.telescope").find_files(true)<CR>

        " Grep.
        nnoremap <silent> <Leader>+ :Telescope live_grep<CR>
        nnoremap <silent> <Leader>/ :Telescope live_grep<CR>
        nnoremap <silent> <Leader>? :Telescope live_grep<CR>
        nnoremap <silent> gR :Telescope grep_string<CR>

        " Git.
        nnoremap <silent> <Leader>gl :Telescope git_bcommits<CR>
        nnoremap <silent> <Leader>gL :Telescope git_commits<CR>
        nnoremap <silent> <Leader>gg :Telescope git_status<CR>
        nnoremap <silent> <Leader>gc :Telescope git_branches<CR>

        " LSP.
        nnoremap <silent> gd :Telescope lsp_definitions<CR>
        nnoremap <silent> gD :Telescope lsp_implementations<CR>
        nnoremap <silent> gr :Telescope lsp_references<CR>
        nnoremap <silent> gy :Telescope lsp_definitions<CR>
        nnoremap <silent> <Leader>s :Telescope lsp_document_symbols<CR>
        nnoremap <silent> <Leader>S :Telescope lsp_dynamic_workspace_symbols<CR>
        nnoremap <silent> <Leader>a :Telescope lsp_code_actions<CR>
        xnoremap <silent> <Leader>a :Telescope lsp_range_code_actions<CR>
        nnoremap <silent> <Leader>l :Telescope lsp_document_diagnostics<CR>
        nnoremap <silent> <Leader>L :Telescope lsp_workspace_diagnostics<CR>

        " Misc.
        nnoremap <silent> mm :Telescope marks<CR>
    ]])
end

return M
