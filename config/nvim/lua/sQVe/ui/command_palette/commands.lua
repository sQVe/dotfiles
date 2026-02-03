-- ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
-- ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
-- ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

local buffer = require('sQVe.utils.buffer')
local git = require('sQVe.utils.git')
local ignored_directory_filter =
  require('sQVe.plugins.snacks.utils').ignored_directory_filter
local path = require('sQVe.utils.path')
local utils = require('sQVe.ui.command_palette.utils')
local var = require('sQVe.utils.var')

local M = {}

M.insert_ascii_header = {
  callback = function()
    vim.ui.input({ prompt = 'ASCII Header: ' }, function(input)
      if input == nil or input == '' then
        return
      end

      local ok = pcall(
        vim.fn.execute,
        'read !toilet -f future ' .. vim.fn.shellescape(input)
      )
      if ok then
        vim.cmd('normal 0Vkkgc')
      end
    end)
  end,
  name = 'Insert (ASCII header)',
}

M.git_blame = {
  callback = function(opts)
    local gitsigns = require('gitsigns')
    gitsigns.blame()
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Git (blame)',
}

M.go_to_buffer = {
  callback = function()
    Snacks.picker.buffers()
  end,
  name = 'Go to (buffer)',
}

M.cwd_buffer_directory = {
  callback = function(opts)
    vim.cmd(
      string.format('cd %s', path.get_parent(buffer.get_path(opts.bufnr)))
    )
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Cwd (buffer directory)', opts)
    )
  end,
}

M.cwd_git_root = {
  callback = function(opts)
    vim.cmd(string.format('cd %s', opts.git_root))
  end,
  condition = function(opts)
    return opts.git_root ~= '' and opts.git_root ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_git_root_path('Cwd (git root)', opts)
    )
  end,
}

M.strip_whitespace = {
  callback = function(opts)
    local region = require('sQVe.utils.selection').get_current_region()
    local lines = vim.api.nvim_buf_get_lines(
      opts.bufnr,
      region.from.line - 1,
      region.to.line,
      false
    )

    for i, line in ipairs(lines) do
      lines[i] = line:gsub('%s+$', '')
    end

    while #lines > 0 and lines[1]:match('^%s*$') do
      table.remove(lines, 1)
    end

    while #lines > 0 and lines[#lines]:match('^%s*$') do
      table.remove(lines)
    end

    local min_indent = math.huge
    for _, line in ipairs(lines) do
      if not line:match('^%s*$') then
        local indent = line:match('^(%s*)'):len()
        min_indent = math.min(min_indent, indent)
      end
    end
    if min_indent == math.huge then
      min_indent = 0
    end

    if min_indent > 0 then
      for i, line in ipairs(lines) do
        if not line:match('^%s*$') then
          lines[i] = line:sub(min_indent + 1)
        end
      end
    end

    local cleaned = {}
    local prev_blank = false
    for _, line in ipairs(lines) do
      local is_blank = line:match('^%s*$') ~= nil
      if not (is_blank and prev_blank) then
        table.insert(cleaned, line)
      end
      prev_blank = is_blank
    end

    vim.api.nvim_buf_set_lines(
      opts.bufnr,
      region.from.line - 1,
      region.to.line,
      false,
      cleaned
    )
  end,
  condition = function(opts)
    return opts.is_visual_mode
  end,
  name = 'Strip (whitespace)',
}

M.buffer_close_hidden = {
  callback = function()
    Snacks.bufdelete.delete(function(bufnr)
      local visible_buffers =
        vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins())

      return not vim.tbl_contains(visible_buffers, bufnr)
    end)
  end,
  name = 'Buffer (close hidden)',
}

M.lsp_code_action = {
  callback = function()
    vim.lsp.buf.code_action()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'LSP (code action)',
}

M.history_commands = {
  callback = function()
    Snacks.picker.command_history()
  end,
  name = 'History (commands)',
}

M.insert_commit_title_from_branch = {
  callback = function()
    local ok = pcall(vim.fn.execute, 'read !git branch --show-current')

    if ok then
      vim.cmd('normal kdd')
      vim.cmd('substitute /\\//: /e')
      vim.cmd('substitute /-/ /e')
      vim.cmd('nohl')
    end
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Insert (commit title from branch)',
}

M.go_to_diagnostic = {
  callback = function()
    Snacks.picker.diagnostics()
  end,
  name = 'Go to (diagnostic)',
}

M.diff_working_changes = {
  callback = function()
    vim.cmd('CodeDiff')
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Diff (working changes)',
}

M.diff_file_commits = {
  callback = function()
    vim.cmd('CodeDiff history HEAD~50 %')
  end,
  condition = function(opts)
    return git.is_inside_repo()
      and buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_path('Diff (file commits)', opts)
    )
  end,
}

M.diff_file_vs_head = {
  callback = function()
    vim.cmd('CodeDiff file HEAD')
  end,
  condition = function(opts)
    return git.is_inside_repo()
      and buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_path('Diff (file vs HEAD)', opts)
    )
  end,
}

M.diff_all_commits = {
  callback = function()
    vim.cmd('CodeDiff history')
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Diff (all commits)',
}

M.go_to_document_symbol = {
  callback = function()
    Snacks.picker.lsp_symbols()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'Go to (document symbol)',
}

M.open_oil = {
  callback = function()
    require('oil').open_float()
  end,
  name = 'Open (Oil)',
}

M.find_all_files = {
  callback = function()
    Snacks.picker.files({
      hidden = true,
      ignored = true,
      follow = true,
    })
  end,
  name = 'Find (all files)',
}

M.find_files = {
  callback = function()
    Snacks.picker.files({
      follow = true,
      hidden = true,
      ignored = false,
    })
  end,
  name = 'Find (files)',
}

M.find_files_in_subdirectory = {
  callback = function(opts)
    Snacks.picker.files({
      cwd = path.get_parent(buffer.get_path(opts.bufnr)),
      follow = true,
      hidden = true,
      ignored = false,
    })
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Find (files)', opts)
    )
  end,
}

M.git_status = {
  callback = function()
    Snacks.picker.git_status()
  end,
  condition = function()
    return git.is_inside_repo() and git.has_changed_files()
  end,
  name = 'Git (status)',
}

M.git_open_in_github = {
  callback = function()
    Snacks.gitbrowse.open()
  end,
  condition = function(opts)
    return git.is_inside_repo()
      and buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_path('Git (open in GitHub)', opts)
    )
  end,
}

M.go_to_help_tag = {
  callback = function()
    Snacks.picker.help()
  end,
  name = 'Go to (help tag)',
}

M.search_in_files = {
  callback = function()
    Snacks.picker.grep({
      follow = true,
      hidden = true,
      ignored = false,
      args = { '--pcre2' },
    })
  end,
  name = 'Search (in files)',
}

M.search_text = {
  callback = function()
    Snacks.picker.grep_word({ regex = false, args = {}, live = true })
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
  end,
  name = function(opts)
    return string.format('Search for `%s` in files', opts.query)
  end,
}

M.search_in_buffers = {
  callback = function()
    Snacks.picker.grep_buffers()
  end,
  name = 'Search (in buffers)',
}

M.search_in_files_subdirectory = {
  callback = function(opts)
    Snacks.picker.grep({
      cwd = path.get_parent(buffer.get_path(opts.bufnr)),
    })
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Search (in files)', opts)
    )
  end,
}

M.insert_icon = {
  callback = function()
    Snacks.picker.icons()
  end,
  name = 'Insert (icon)',
}

M.insert_file_paths = {
  callback = function()
    Snacks.picker.files({
      follow = true,
      hidden = true,
      ignored = false,
      multiple = true,
      confirm = function(picker, item)
        picker:close()
        local selected = picker:selected()

        -- If nothing explicitly selected, use the current item
        if #selected == 0 and item then
          selected = { item }
        end

        local paths = vim.tbl_map(function(i)
          return vim.fn.fnamemodify(i.file, ':.')
        end, selected)

        vim.api.nvim_put(paths, 'l', true, true)
      end,
    })
  end,
  name = 'Insert (file paths)',
}

M.go_to_line = {
  callback = function()
    Snacks.picker.lines()
  end,
  name = 'Go to (line)',
}

M.git_merge_base = {
  callback = function()
    local gitsigns = package.loaded.gitsigns

    gitsigns.show(git.get_merge_base())
  end,
  condition = function(opts)
    return git.is_inside_repo()
      and buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_path('Git (merge base)', opts)
    )
  end,
}

M.go_to_mark = {
  callback = function()
    Snacks.picker.marks()
  end,
  name = 'Go to (mark)',
}

M.git_previous_commit_message = {
  callback = function()
    vim.fn.execute('vsplit /tmp/PREV_COMMIT_EDITMSG')
  end,
  condition = function()
    local file_handle = io.open('/tmp/PREV_COMMIT_EDITMSG', 'r')
    if file_handle == nil then
      return false
    end

    file_handle:close()
    return true
  end,
  name = 'Git (previous commit message)',
}

M.open_project = {
  callback = function()
    Snacks.picker.projects()
  end,
  name = 'Open (project)',
}

M.go_to_recent_file = {
  callback = function()
    Snacks.picker.recent({
      filter = {
        cwd = true,
        filter = ignored_directory_filter,
      },
    })
  end,
  name = 'Go to (recent file)',
}

M.lsp_rename_symbol = {
  callback = function()
    vim.lsp.buf.rename()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = function(opts)
    return string.format('LSP (rename symbol `%s`)', opts.query)
  end,
}

M.pr_review_commits = {
  callback = function()
    vim.cmd('CodeDiff history origin/' .. git.get_default_branch() .. '..HEAD')
  end,
  condition = function()
    return git.is_inside_repo()
      and git.get_branch_name() ~= git.get_default_branch()
  end,
  name = 'PR review (by commit)',
}

M.pr_review_diff = {
  callback = function()
    vim.cmd('CodeDiff ' .. git.get_default_branch() .. '...')
  end,
  condition = function()
    return git.is_inside_repo()
      and git.get_branch_name() ~= git.get_default_branch()
  end,
  name = 'PR review (all changes)',
}

M.search_and_replace = {
  callback = function()
    require('grug-far').open()
  end,
  name = 'Search (and replace)',
}

M.history_search = {
  callback = function()
    Snacks.picker.search_history()
  end,
  name = 'History (search)',
}

M.spawn_yazi = {
  callback = function()
    vim.system({ 'term', 'yazi' }, { detach = true }):wait()
  end,
  name = 'Spawn (yazi)',
}

M.spawn_yazi_in_subdirectory = {
  callback = function(opts)
    vim
      .system({
        'term',
        'yazi',
        buffer.get_path(opts.bufnr),
      }, { detach = true })
      :wait()
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr) and buffer.is_saved(opts.bufnr)
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Spawn (yazi)', opts)
    )
  end,
}

M.spawn_lazygit = {
  callback = function()
    vim.system({ 'term', 'lazygit' }, { detach = true }):wait()
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Spawn (lazygit)',
}

M.spawn_lazygit_with_filter = {
  callback = function(opts)
    vim
      .system({
        'term',
        'lazygit',
        '--filter',
        buffer.get_path(opts.bufnr),
      }, { detach = true })
      :wait()
  end,
  condition = function(opts)
    return git.is_inside_repo()
      and buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Spawn (lazygit)', opts)
    )
  end,
}

M.spawn_terminal = {
  callback = function()
    vim.system({ 'term' }, { detach = true }):wait()
  end,
  name = 'Spawn (terminal)',
}

M.spawn_terminal_in_subdirectory = {
  callback = function(opts)
    vim
      .system({
        'term',
        path.get_parent(buffer.get_path(opts.bufnr)),
      }, { detach = true })
      :wait()
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Spawn (terminal)', opts)
    )
  end,
}

M.spawn_claude = {
  callback = function()
    vim.system({ 'term', 'command claude' }, { detach = true }):wait()
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Spawn (Claude)',
}

M.fix_spelling = {
  callback = function()
    Snacks.picker.spelling()
  end,
  name = 'Fix (spelling)',
}

M.toggle_conceal = {
  callback = function(opts)
    vim.wo[opts.winnr].conceallevel = vim.wo[opts.winnr].conceallevel == 0 and 2
      or 0
  end,
  name = 'Toggle (conceal)',
}

M.toggle_format_on_save = {
  callback = function()
    var.toggle_global('format_on_save')
  end,
  condition = function()
    local conform = require('lazy.core.config').plugins['conform.nvim']

    return conform ~= nil and conform._.loaded
  end,
  name = 'Toggle (format on save)',
}

M.git_toggle_inline_diff = {
  callback = function(opts)
    require('mini.diff').toggle_overlay(opts.bufnr)
    var.toggle_buffer(opts.bufnr, 'git_diff')
  end,
  condition = function()
    local mini_diff = require('lazy.core.config').plugins['mini.diff']

    return git.is_inside_repo() and mini_diff ~= nil and mini_diff._.loaded
  end,
  name = 'Git (toggle inline diff)',
}

M.toggle_relative_numbers = {
  callback = function(opts)
    vim.wo[opts.winnr].relativenumber = not vim.wo[opts.winnr].relativenumber
  end,
  name = 'Toggle (relative numbers)',
}

M.toggle_spell_check = {
  callback = function(opts)
    vim.wo[opts.winnr].spell = not vim.wo[opts.winnr].spell
  end,
  name = 'Toggle (spell check)',
}

M.toggle_line_wrap = {
  callback = function(opts)
    vim.wo[opts.winnr].wrap = not vim.wo[opts.winnr].wrap
  end,
  name = 'Toggle (line wrap)',
}

M.history_undo = {
  callback = function()
    Snacks.picker.undo()
  end,
  name = 'History (undo)',
}

M.go_to_workspace_symbol = {
  callback = function()
    Snacks.picker.lsp_workspace_symbols()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'Go to (workspace symbol)',
}

M.copy_filename = {
  callback = function(opts)
    local bufnr = opts.bufnr or 0
    local file_path = buffer.get_path(bufnr)

    if file_path == '' then
      vim.notify('Buffer has no file path', vim.log.levels.WARN)
      return
    end

    vim.fn.setreg('+', file_path)
    vim.notify('Copied: ' .. file_path)
  end,
  condition = function(opts)
    return not opts.is_visual_mode
  end,
  name = 'Copy (filename)',
}

M.copy_filename_with_line = {
  callback = function(opts)
    local bufnr = opts.bufnr or 0
    local file_path = buffer.get_path(bufnr)

    if file_path == '' then
      vim.notify('Buffer has no file path', vim.log.levels.WARN)
      return
    end

    local result
    if opts.is_visual_mode then
      local region = require('sQVe.utils.selection').get_current_region()
      if region.from.line == region.to.line then
        result = string.format('%s:%d', file_path, region.from.line)
      else
        result =
          string.format('%s:%d-%d', file_path, region.from.line, region.to.line)
      end
    else
      local line = vim.api.nvim_win_get_cursor(0)[1]
      result = string.format('%s:%d', file_path, line)
    end

    vim.fn.setreg('+', result)
    vim.notify('Copied: ' .. result)
  end,
  name = 'Copy (filename with line)',
}

M.history_yank = {
  callback = function()
    Snacks.picker.yanky()
  end,
  name = 'History (yank)',
}

return M
