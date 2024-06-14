-- ╺┳╸┏━╸╻  ┏━╸┏━┓┏━╸┏━┓┏━┓┏━╸
--  ┃ ┣╸ ┃  ┣╸ ┗━┓┃  ┃ ┃┣━┛┣╸
--  ╹ ┗━╸┗━╸┗━╸┗━┛┗━╸┗━┛╹  ┗━╸
-- Fuzzy finder.

local commands = require('sQVe.ui.command_palette.commands')

local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      'danielfalk/smart-open.nvim',
      branch = '0.2.x',
      dependencies = { 'kkharji/sqlite.lua' },
    },
  },
  keys = {
    {
      'z=',
      function()
        require('telescope.builtin').spell_suggest({
          prompt_title = 'Spell suggest',
        })
      end,
      desc = 'Spell suggest',
    },
    {
      '<Backspace>',
      function()
        require('sQVe.ui.command_palette').open_command_palette()
      end,
      desc = 'Command palette',
      mode = { 'n', 'v' },
    },
    {
      'ä',
      function()
        commands.smart_open.callback()
      end,
      desc = 'Smart open',
      mode = { 'n', 'v' },
    },
    {
      'å',
      function()
        commands.live_grep.callback()
      end,
      desc = 'Live grep',
      mode = { 'n', 'v' },
    },
    {
      'M',
      function()
        commands.marks.callback()
      end,
      desc = 'Go to mark',
      mode = { 'n' },
    },
  },
}

M.opts = function()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  return {
    defaults = {
      cache_picker = { ignore_empty = true, num_pickers = -1 },
      dynamic_preview_title = true,
      layout_strategy = 'flex',
      layout_config = {
        height = 0.8,
        prompt_position = 'top',
        width = 0.8,
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
              vim.cmd(string.format('edit %s', file_selection.path))
            end
          end,
          ['<Esc>'] = actions.close,
        },
      },
      scroll_strategy = 'limit',
      sorting_strategy = 'ascending',
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--column',
        '--glob=!pnpm-lock.yaml',
        '--hidden',
        '--line-number',
        '--no-heading',
        '--trim',
        '--with-filename',
      },
    },
    extensions = {
      fzf = {
        case_mode = 'respect_case',
        override_file_sorter = true,
        override_generic_sorter = false,
      },
      smart_open = {
        match_algorithm = 'fzf',
        ignore_patterns = {
          '*.git/*',
          '*.next/*',
          '*/node_modules/*',
          '*/tmp/*',
        },
      },
    },
    pickers = {
      find_files = {
        find_command = {
          'fd',
          '--hidden',
          '--type',
          'file',
          '--exclude',
          '.git',
          '--exclude',
          '.steam',
          '--exclude',
          'Steam',
        },
      },
    },
  }
end

M.config = function(_, opts)
  local telescope = require('telescope')

  telescope.setup(opts)
  telescope.load_extension('fzf')
  telescope.load_extension('smart_open')
end

return M
