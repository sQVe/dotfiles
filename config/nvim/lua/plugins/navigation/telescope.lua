-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸
local M = {}

M.find_buffer_files = function()
    local builtin = require('telescope.builtin')
    local utils = require('telescope.utils')
    local opts = {cwd = utils.buffer_dir(), follow = true, hidden = true}

    builtin.find_files(opts)
end

M.config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup {
        defaults = {
            layout_config = {
                height = 0.75,
                preview_cutoff = 150,
                preview_width = 0.5,
                prompt_position = "top",
                width = 0.75
            },
            mappings = {
                i = {
                    ["<C-s>"] = actions.select_horizontal,
                    ["<esc>"] = actions.close,
                    ["<Leader>q"] = actions.close
                }
            },
            sorting_strategy = "ascending",
            vimgrep_arguments = {
                {
                    "rg", "--color=never", "--column", "--hidden",
                    "--line-number", "--no-heading", "--with-filename"
                }
            }
        }
    }

    telescope.load_extension('fzf')

    vim.cmd([[
        " Telescope.
        nnoremap <silent> - :Telescope<CR>
        nnoremap <silent> _ :Telescope resume<CR>

        " Files and buffers.
        nnoremap <silent> <Backspace> :Telescope buffers<CR>
        nnoremap <silent> ä :Telescope find_files follow=true hidden=true<CR>
        nnoremap <silent> å :lua require("plugins.navigation.telescope").find_buffer_files()<CR>

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
