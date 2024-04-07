-- ┏━┓╻┏━╸╻┏ ┏━╸┏━┓┏━┓
-- ┣━┛┃┃  ┣┻┓┣╸ ┣┳┛┗━┓
-- ╹  ╹┗━╸╹ ╹┗━╸╹┗╸┗━┛

local M = {}

M.find_files = function(opts)
  local builtin = require('telescope.builtin')

  opts = vim.tbl_extend('force', {
    cwd = vim.fn.getcwd(),
    follow = true,
    hidden = true,
    path_display = { 'truncate' },
    prompt_title = 'Find file',
    show_untracked = true,
    use_git_root = false,
  }, opts or {})

  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

-- Create custom Git status picker since the builtin one fails to open via a
-- select window.
M.git_status = function(opts)
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local conf = require('telescope.config').values
  local finders = require('telescope.finders')
  local make_entry = require('telescope.make_entry')
  local pickers = require('telescope.pickers')
  local previewers = require('telescope.previewers')
  local utils = require('telescope.utils')

  local args = { 'status', '--porcelain=v1', '-uall', '--', '.' }

  local finder = function()
    local git_cmd = utils.__git_command(args, opts)
    opts.entry_maker = make_entry.gen_from_git_status(opts)
    return finders.new_oneshot_job(git_cmd, opts)
  end

  local initial_finder = finder()
  if not initial_finder then
    return
  end

  pickers
    .new(opts, {
      prompt_title = 'Git status',
      finder = initial_finder,
      previewer = previewers.git_file_diff.new(opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.git_staging_toggle:enhance({
          post = function()
            local picker = action_state.get_current_picker(prompt_bufnr)

            local selection = picker:get_selection_row()
            local callbacks = { unpack(picker._completion_callbacks) }
            picker:register_completion_callback(function(self)
              self:set_selection(selection)
              self._completion_callbacks = callbacks
            end)

            picker:refresh(finder(), { reset_prompt = false })
          end,
        })

        map({ 'i', 'n' }, '<Tab>', actions.git_staging_toggle)
        return true
      end,
    })
    :find()
end

return M
