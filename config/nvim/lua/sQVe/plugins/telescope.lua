-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸
-- Fuzzy finder.

local M = {}

M.init = function(use)
  use({
    'nvim-telescope/telescope.nvim',
    config = M.config,
    event = 'BufEnter',
    module = 'telescope',
    requires = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        module = 'telescope._extensions.fzf',
        run = 'make',
      },
    },
  })
end

M.git_status = function()
  local builtin = require('telescope.builtin')

  local ok = pcall(builtin.git_status, {})
  if not ok then
    print('No git directory found')
  end
end

M.find_files = function(use_buffer_cwd)
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  local opts = {
    follow = true,
    hidden = true,
    show_untracked = true,
    use_git_root = false,
  }

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
  local builtin = require('telescope.builtin')

  local map = require('sQVe.utils.vim').map

  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      layout_strategy = 'flex',
      layout_config = {
        height = 0.9,
        prompt_position = 'top',
        width = 0.9,
        flex = { flip_columns = 280 },
        vertical = { preview_height = 0.4 },
      },
      mappings = {
        i = {
          ['<C-Down>'] = actions.cycle_history_next,
          ['<C-Up>'] = actions.cycle_history_prev,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-a>'] = actions.toggle_all,
          ['<C-s>'] = actions.select_horizontal,
          ['<C-x>'] = actions.delete_buffer,
          ['<Esc>'] = actions.close,
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

  map('n', '<Leader>u', function()
    builtin.oldfiles({ cwd_only = true })
  end)
  map('n', '<Leader>U', builtin.resume)

  map('n', '<Backspace>', function()
    builtin.buffers({ sort_mru = true })
  end)
  map('n', '<Leader><Backspace>', require('sQVe.plugins.telescope').git_status)

  map('n', 'gR', builtin.grep_string)
  map('n', 'gd', builtin.lsp_definitions)
  map('n', 'gD', builtin.lsp_implementations)
  map('n', 'gr', builtin.lsp_references)
  map('n', 'gy', builtin.lsp_type_definitions)
  map('n', '<Leader>l', function()
    builtin.diagnostics({ bufnr = 0 })
  end)
  map('n', '<Leader>L', builtin.diagnostics)
  map('n', '<Leader>s', builtin.lsp_dynamic_workspace_symbols)
  map('n', '<Leader>S', builtin.lsp_document_symbols)
  map('n', 'z=', builtin.spell_suggest)

  map('n', 'å', builtin.live_grep)
  map('n', 'ä', require('sQVe.plugins.telescope').find_files)
  map('n', 'Ä', function()
    require('sQVe.plugins.telescope').find_files(true)
  end)
end

return M