-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸
local M = {}

M.find_root_files = function()
    local builtin = require('telescope.builtin')
    local opts = {follow = true}

    local ok = pcall(builtin.git_files, opts)
    if not ok then builtin.find_files(opts) end
end

M.find_buffer_files = function()
    local builtin = require('telescope.builtin')
    local utils = require('telescope.utils')
    local opts = {cwd = utils.buffer_dir(), follow = true, use_git_root = false}

    local ok = pcall(builtin.git_files, opts)
    if not ok then builtin.find_files(opts) end
end

M.config = function()
    local actions = require('telescope.actions')
    local telescope = require("telescope")

    telescope.setup {
        defaults = {
            layout_config = {
                horizontal = {
                    height = 0.9,
                    preview_cutoff = 120,
                    prompt_position = "top",
                    width = 0.8
                }
            },
            mappings = {
                i = {
                    ["<C-s>"] = actions.select_horizontal,
                    ["<esc>"] = actions.close
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
        " Files and buffers.
        nnoremap <silent> <Backspace> :Telescope buffers<CR>
        nnoremap <silent> ä :lua require("plugins.navigation.telescope").find_root_files()<CR>
        nnoremap <silent> å :lua require("plugins.navigation.telescope").find_buffer_files()<CR>

        " Grep.
        nnoremap <silent> <Leader>+ :Telescope live_grep<CR>
        nnoremap <silent> <Leader>/ :Telescope live_grep<CR>
        nnoremap <silent> <Leader>? :Telescope live_grep<CR>
        nnoremap <silent> gR Telescrope grep_string<CR>

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
        nnoremap <silent> <Leader>S :Telescope lsp_dynamic_workspace_symbols()<CR>
        nnoremap <silent> <Leader>a :Telescope lsp_code_actions<CR>
        xnoremap <silent> <Leader>a :Telescope lsp_range_code_actions<CR>
        nnoremap <silent> <Leader>l :Telescope lsp_document_diagnostics<CR>
        nnoremap <silent> <Leader>L :Telescope lsp_workspace_diagnostics<CR>

        " Misc.
        nnoremap <silent> mm :Telescope marks<CR>
    ]])
end

return M
