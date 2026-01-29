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
  commands.ascii_header,
  commands.blame,
  commands.buffers,
  commands.change_cwd_buffer_path,
  commands.change_cwd_git_root_path,
  commands.clean_whitespace,
  commands.close_hidden_buffers,
  commands.code_action,
  commands.command_history,
  commands.commit_message_from_branch_name,
  commands.copy_filename,
  commands.copy_filename_with_line,
  commands.create_new_daily_note,
  commands.create_new_note,
  commands.diagnostics,
  commands.diff_view,
  commands.document_symbols,
  commands.file_explorer,
  commands.find_all_files,
  commands.find_files,
  commands.find_files_in_subdirectory,
  commands.git_browse,
  commands.git_status,
  commands.grep,
  commands.grep_buffers,
  commands.grep_subdirectory,
  commands.grep_text,
  commands.help_tags,
  commands.icons,
  commands.input_file_paths,
  commands.lines,
  commands.marks,
  commands.merge_base,
  commands.pr_review_commits,
  commands.pr_review_diff,
  commands.previous_commit_message,
  commands.projects,
  commands.recent_files,
  commands.rename_symbol,
  commands.resume,
  commands.search_and_replace,
  commands.search_history,
  commands.spawn_claude,
  commands.spawn_file_manager,
  commands.spawn_file_manager_in_subdirectory,
  commands.spawn_lazygit,
  commands.spawn_lazygit_with_filter,
  commands.spawn_terminal,
  commands.spawn_terminal_in_subdirectory,
  commands.spelling,
  commands.toggle_conceal_level,
  commands.toggle_format_on_save,
  commands.toggle_inline_diff,
  commands.toggle_relative_numbers,
  commands.toggle_spell,
  commands.toggle_wrap,
  commands.undo,
  commands.workspace_symbols,
  commands.yank_ring,
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
