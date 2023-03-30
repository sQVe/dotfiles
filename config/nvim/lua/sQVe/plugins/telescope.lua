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
        require('sQVe.utils.telescope').git_status()
      end,
      desc = 'Git status',
    },
    {
      '<Leader><Backspace>',
      function()
        require('telescope.builtin').buffers({ sort_mru = true })
      end,
      desc = 'Buffers',
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
        require('sQVe.utils.telescope').find_files(true)
      end,
      'Find file (buffer directory)',
    },
    {
      'Ä',
      function()
        require('sQVe.utils.telescope').find_files()
      end,
      desc = 'Find file',
    },
  },
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
}

M.opts = function()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

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
          ['<C-a>'] = actions.toggle_all,
          ['<C-f>'] = actions.to_fuzzy_refine,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-s>'] = actions.select_horizontal,
          ['<C-x>'] = actions.drop_all,
          ['<CR>'] = function(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            local multi_selections = picker.get_multi_selection(picker)

            local file_selections = vim.tbl_filter(function(selection)
              return selection.path ~= nil
            end, multi_selections)

            if vim.tbl_isempty(file_selections) then
              actions.select_default(prompt_bufnr)
            else
              actions.close(prompt_bufnr)
            end

            for _, file_selection in pairs(file_selections) do
              vim.cmd(string.format('%s %s', 'edit', file_selection.path))
            end
          end,
          ['<Esc>'] = actions.close,
        },
      },
      preview = { treesitter = { enable = false } },
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
