-- ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓   ┏━┓┏━┓╻  ┏━╸╺┳╸╺┳╸┏━╸
-- ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃   ┣━┛┣━┫┃  ┣╸  ┃  ┃ ┣╸
-- ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛   ╹  ╹ ╹┗━╸┗━╸ ╹  ╹ ┗━╸

local buffer = require('sQVe.utils.buffer')
local git = require('sQVe.utils.git')
local path = require('sQVe.utils.path')
local selection = require('sQVe.utils.selection')

local commands = require('sQVe.ui.command_palette.commands')

local M = {}

local default_commands = {
  commands.buffer_close_hidden,
  commands.copy_filename,
  commands.copy_filename_with_line,
  commands.cwd_buffer_directory,
  commands.cwd_git_root,
  commands.diff_all_commits,
  commands.diff_branch_commits,
  commands.diff_branch_vs_main,
  commands.diff_file_commits,
  commands.diff_file_vs_head,
  commands.diff_working_changes,
  commands.find_all_files,
  commands.find_files,
  commands.find_files_in_subdirectory,
  commands.fix_spelling,
  commands.git_blame,
  commands.git_merge_base,
  commands.git_open_in_github,
  commands.git_previous_commit_message,
  commands.git_status,
  commands.git_toggle_inline_diff,
  commands.go_to_buffer,
  commands.go_to_diagnostic,
  commands.go_to_document_symbol,
  commands.go_to_help_tag,
  commands.go_to_line,
  commands.go_to_mark,
  commands.go_to_recent_file,
  commands.go_to_workspace_symbol,
  commands.history_commands,
  commands.history_search,
  commands.history_undo,
  commands.history_yank,
  commands.insert_ascii_header,
  commands.insert_commit_title_from_branch,
  commands.insert_file_paths,
  commands.insert_icon,
  commands.lsp_code_action,
  commands.lsp_rename_symbol,
  commands.open_oil,
  commands.open_project,
  commands.search_and_replace,
  commands.search_in_buffers,
  commands.search_in_files,
  commands.search_in_files_subdirectory,
  commands.search_text,
  commands.spawn_claude,
  commands.spawn_lazygit,
  commands.spawn_lazygit_with_filter,
  commands.spawn_terminal,
  commands.spawn_terminal_in_subdirectory,
  commands.spawn_yazi,
  commands.spawn_yazi_in_subdirectory,
  commands.strip_whitespace,
  commands.toggle_conceal,
  commands.toggle_format_on_save,
  commands.toggle_line_wrap,
  commands.toggle_relative_numbers,
  commands.toggle_spell_check,
}

M.open_command_palette = function(additional_commands)
  local visual_mode = selection.get_visual_mode()

  local opts = {
    bufnr = buffer.get_bufnr(),
    cwd = path.get_cwd(),
    git_root = '',
    is_visual_mode = selection.is_visual_mode(),
    query = '',
    winnr = vim.api.nvim_get_current_win(),
  }

  if git.is_inside_repo() then
    opts.git_root = git.get_root()
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
