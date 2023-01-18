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
    },
    { '<Leader>U', '<Cmd>Telescope resume<CR>' },
    {
      '<Backspace>',
      function()
        require('telescope.builtin').buffers({ sort_mru = true })
      end,
    },
    {
      '<Leader><Backspace>',
      function()
        require('sQVe.plugins.telescope').git_status()
      end,
    },
    { 'gR', '<Cmd>Telescope grep_string<CR>' },
    { 'z=', '<Cmd>Telescope spell_suggest<CR>' },
    {
      'å',
      function()
        require('telescope.builtin').live_grep({
          prompt_title = 'Grep In Open Buffers',
          grep_open_files = true,
        })
      end,
    },
    {
      'Å',
      function()
        require('telescope.builtin').live_grep({
          prompt_title = 'Grep In All Files',
        })
      end,
    },
    {
      'ä',
      function()
        require('sQVe.plugins.telescope').find_files(true)
      end,
    },
    {
      'Ä',
      function()
        require('sQVe.plugins.telescope').find_files()
      end,
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
    prompt_title = use_buffer_cwd and 'Find Buffer Sibling File' or 'Find File',
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
