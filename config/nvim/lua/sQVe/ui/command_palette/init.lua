-- ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓   ┏━┓┏━┓╻  ┏━╸╺┳╸╺┳╸┏━╸
-- ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃   ┣━┛┣━┫┃  ┣╸  ┃  ┃ ┣╸
-- ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛   ╹  ╹ ╹┗━╸┗━╸ ╹  ╹ ┗━╸

local selection = require('sQVe.utils.selection')
local commands = require('sQVe.ui.command_palette.commands')

local M = {}

local default_commands = {
  commands.buffers,
  commands.change_cwd_buffer_path,
  commands.change_cwd_git_root_path,
  commands.commit_message_from_branch_name,
  commands.diagnostics,
  commands.file_explorer,
  commands.find_files,
  commands.find_files_in_subdirectory,
  commands.git_status,
  commands.grep_text,
  commands.lazygit,
  commands.lazygit_with_filter,
  commands.live_grep,
  commands.live_grep_in_subdirectory,
  commands.previous_commit_message,
  commands.recent_files,
  commands.resume,
  commands.search_history,
  commands.terminal,
  commands.terminal_in_subdirectory,
  commands.toggle_format_on_save,
  commands.toggle_git_blame,
  commands.toggle_git_diff_overlay,
  commands.yazi,
  commands.yazi_in_subdirectory,
}

M.open_command_palette = function(additional_commands)
  local visual_mode = selection.get_visual_mode()

  local opts = {
    bufnr = vim.api.nvim_get_current_buf(),
    cwd = vim.fn.getcwd(),
    git_root = '',
    is_visual_mode = selection.is_visual_mode(),
    query = '',
    winnr = vim.api.nvim_get_current_win(),
  }

  local is_inside_git_repo = vim
    .system({
      'git',
      'rev-parse',
      '--is-inside-work-tree',
    })
    :wait().code == 0

  if is_inside_git_repo then
    opts.git_root = vim.trim(vim
      .system({
        'git',
        'rev-parse',
        '--show-toplevel',
      }, { text = true })
      :wait().stdout)
  end

  opts.query = visual_mode == 'char'
      and selection.get_region_text(selection.get_current_region(), visual_mode)[1]
    or vim.fn.expand('<cword>')

  local merged_commands =
    vim.tbl_extend('force', default_commands, additional_commands or {})

  merged_commands = vim.tbl_filter(function(command)
    return not command.condition or command.condition(opts)
  end, merged_commands)

  table.sort(merged_commands, function(a, b)
    local names = {
      type(a.name) == 'string' and a.name or a.name(opts),
      type(b.name) == 'string' and b.name or b.name(opts),
    }

    return names[1] < names[2]
  end)

  vim.ui.select(merged_commands, {
    prompt = 'Command palette',
    format_item = function(item)
      return type(item.name) == 'string' and item.name or item.name(opts)
    end,
  }, function(choice)
    if choice then
      choice.callback(opts)
    end
  end)
end

return M
