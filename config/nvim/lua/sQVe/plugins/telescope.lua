-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸
-- Fuzzy finder.

local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    {
      '<Leader>u',
      function()
        require('telescope.builtin').oldfiles({
          cwd_only = true,
          sort_lastused = true,
        })
      end,
      desc = 'Recent files',
    },
    { '<Leader>U', '<Cmd>Telescope resume<CR>', desc = 'Resume' },
    {
      '<Backspace>',
      function()
        require('telescope.builtin').buffers({ sort_mru = true })
      end,
      desc = 'Buffers',
    },
    {
      '<Leader><Backspace>',
      function()
        require('sQVe.plugins.telescope').git_status()
      end,
      desc = 'Git status',
    },
    { 'gR', '<Cmd>Telescope grep_string<CR>', desc = 'Grep word' },
    { 'z=', '<Cmd>Telescope spell_suggest<CR>', desc = 'Spell suggest' },
    {
      'å',
      function()
        require('telescope.builtin').live_grep({
          prompt_title = 'Grep (open buffers)',
          grep_open_files = true,
        })
      end,
      desc = 'Grep (open buffers)',
    },
    {
      'Å',
      function()
        require('telescope.builtin').live_grep({
          prompt_title = 'Grep',
        })
      end,
      desc = 'Grep',
    },
    {
      'ä',
      function()
        require('sQVe.plugins.telescope').find_files(true)
      end,
      'Find file (buffer directory)',
    },
    {
      'Ä',
      function()
        require('sQVe.plugins.telescope').find_files()
      end,
      desc = 'Find file',
    },
  },
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
}

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
    prompt_title = use_buffer_cwd and 'Find file (buffer directory)'
      or 'Find file',
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

M.opts = function()
  local actions = require('telescope.actions')

  return {
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
  }
end

M.config = function(_, opts)
  local telescope = require('telescope')

  telescope.setup(opts)
  telescope.load_extension('fzf')
end

return M
