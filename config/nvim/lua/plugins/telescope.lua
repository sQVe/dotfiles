-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸

local M = {}

M.find_files = function(use_buffer_cwd)
  local builtin = require('telescope/builtin')
  local utils = require('telescope/utils')
  local opts = { follow = true, hidden = true, use_git_root = false }

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

  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      layout_strategy = 'flex',
      layout_config = {
        height = 0.8,
        prompt_position = 'top',
        width = 0.8,
        flex = { flip_columns = 280 },
        horizontal = { preview_width = 80 },
        vertical = { preview_height = 0.25 },
      },
      mappings = {
        i = {
          ['<C-Down>'] = actions.cycle_history_next,
          ['<C-Up>'] = actions.cycle_history_prev,
          ['<C-s>'] = actions.select_horizontal,
          ['<Esc>'] = actions.close,
          ['<Leader>q'] = actions.close,
        },
      },
      scroll_strategy = 'limit',
      sorting_strategy = 'ascending',
      vimgrep_arguments = {
        {
          'rg',
          '--color=never',
          '--column',
          '--hidden',
          '--line-number',
          '--no-heading',
          '--with-filename',
          '--trim',
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      },
    },
  })

  -- Use fzf native.
  telescope.load_extension('fzf')

  vim.cmd([[
    " Telescope.
    nnoremap <silent> - <Cmd>Telescope<CR>
    nnoremap <silent> _ <Cmd>Telescope resume<CR>

    " Files and buffers.
    nnoremap <silent> <Leader><Backspace> <Cmd>Telescope buffers sort_mru=true<CR>
    nnoremap <silent> ä <Cmd>lua require("plugins.telescope").find_files()<CR>
    nnoremap <silent> å <Cmd>lua require("plugins.telescope").find_files(true)<CR>

    " Grep.
    nnoremap <silent> <Leader>+ <Cmd>Telescope live_grep<CR>
    nnoremap <silent> <Leader>/ <Cmd>Telescope live_grep<CR>
    nnoremap <silent> <Leader>? <Cmd>Telescope live_grep<CR>
    nnoremap <silent> gR <Cmd>Telescope grep_string<CR>

    " Git.
    nnoremap <silent> <Leader>gl <Cmd>Telescope git_bcommits<CR>
    nnoremap <silent> <Leader>gL <Cmd>Telescope git_commits<CR>
    nnoremap <silent> <Leader>gg <Cmd>Telescope git_status<CR>
    nnoremap <silent> <Leader>gc <Cmd>Telescope git_branches<CR>

    " Git worktrees.
    nnoremap <silent> <Leader>gw <Cmd>Telescope git_worktree git_worktrees<CR>
    nnoremap <silent> <Leader>gW <Cmd>Telescope git_worktree create_git_worktree<CR>

    " LSP.
    nnoremap <silent> gd <Cmd>Telescope lsp_definitions<CR>
    nnoremap <silent> gD <Cmd>Telescope lsp_implementations<CR>
    nnoremap <silent> gr <Cmd>Telescope lsp_references<CR>
    nnoremap <silent> gy <Cmd>Telescope lsp_definitions<CR>
    nnoremap <silent> <Leader>a <Cmd>Telescope lsp_code_actions<CR>
    xnoremap <silent> <Leader>a <Cmd>Telescope lsp_range_code_actions<CR>
    nnoremap <silent> <Leader>l <Cmd>Telescope diagnostics bufnr=0<CR>
    nnoremap <silent> <Leader>L <Cmd>Telescope diagnostics<CR>
    nnoremap <silent> <Leader>s <Cmd>Telescope lsp_document_symbols<CR>
    nnoremap <silent> <Leader>S <Cmd>Telescope lsp_dynamic_workspace_symbols<CR>

    " Misc.
    nnoremap <silent> mm <Cmd>Telescope marks<CR>
  ]])
end

return M
