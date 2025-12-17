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

M.blame = {
  callback = function(opts)
    local gitsigns = require('gitsigns')
    gitsigns.blame()
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Blame',
}

M.buffers = {
  callback = function()
    Snacks.picker.buffers()
  end,
  name = 'Go to buffer',
}

M.change_cwd_buffer_path = {
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
      utils.get_name_with_buffer_directory('Set cwd to buffer directory', opts)
    )
  end,
}

M.change_cwd_git_root_path = {
  callback = function(opts)
    vim.cmd(string.format('cd %s', opts.git_root))
  end,
  condition = function(opts)
    return opts.git_root ~= '' and opts.git_root ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_git_root_path('Set cwd to git root', opts)
    )
  end,
}

M.close_hidden_buffers = {
  callback = function()
    Snacks.bufdelete.delete(function(bufnr)
      local visible_buffers =
        vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins())

      return not vim.tbl_contains(visible_buffers, bufnr)
    end)
  end,
  name = 'Close hidden buffers',
}

M.code_action = {
  callback = function()
    vim.lsp.buf.code_action()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'Apply code action',
}

M.command_history = {
  callback = function()
    Snacks.picker.command_history()
  end,
  name = 'Command history',
}

M.commit_message_from_branch_name = {
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
  name = 'Generate commit message title from branch name',
}

M.create_new_daily_note = {
  callback = function()
    require('notebox.note').new_note('daily')
  end,
  name = 'Create new daily note',
}

M.create_new_note = {
  callback = function()
    require('notebox.note').new_note()
  end,
  name = 'Create new note',
}

M.diagnostics = {
  callback = function()
    Snacks.picker.diagnostics()
  end,
  name = 'Go to diagnostic',
}

M.diff_view = {
  callback = function()
    vim.cmd('CodeDiff')
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Open diff view',
}

M.document_symbols = {
  callback = function()
    Snacks.picker.lsp_symbols()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'Go to document symbol',
}

M.file_explorer = {
  callback = function()
    require('mini.files').open(buffer.get_path(), false)
  end,
  name = 'File explorer',
}

M.find_all_files = {
  callback = function()
    Snacks.picker.files({
      hidden = true,
      ignored = true,
      follow = true,
    })
  end,
  name = 'Find all files (including ignored)',
}

M.find_files = {
  callback = function()
    Snacks.picker.files({
      follow = true,
      hidden = true,
      ignored = false,
    })
  end,
  name = 'Find files',
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
      utils.get_name_with_buffer_directory('Find files', opts)
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
  name = 'Git status',
}

M.git_browse = {
  callback = function()
    Snacks.gitbrowse.open()
  end,
  condition = function(opts)
    return git.is_inside_repo()
      and buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
  end,
  name = 'Open buffer in browser',
}

M.help_tags = {
  callback = function()
    Snacks.picker.help()
  end,
  name = 'Go to help tag',
}

M.grep = {
  callback = function()
    Snacks.picker.grep({
      follow = true,
      hidden = true,
      ignored = false,
      args = { '--pcre2' },
    })
  end,
  name = 'Grep',
}

M.grep_text = {
  callback = function()
    Snacks.picker.grep_word()
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
  end,
  name = function(opts)
    return string.format(
      'Grep %s `%s`',
      opts.is_visual_mode and 'selection' or 'word',
      opts.query
    )
  end,
}

M.grep_buffers = {
  callback = function()
    Snacks.picker.grep_buffers()
  end,
  name = 'Grep in open buffers',
}

M.grep_subdirectory = {
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
      utils.get_name_with_buffer_directory('Grep', opts)
    )
  end,
}

M.icons = {
  callback = function()
    Snacks.picker.icons()
  end,
  name = 'Get icon',
}

M.lines = {
  callback = function()
    Snacks.picker.lines()
  end,
  name = 'Go to line',
}

M.merge_base = {
  callback = function()
    local gitsigns = package.loaded.gitsigns

    gitsigns.show(git.get_merge_base())
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Show merge base version', opts)
    )
  end,
}

M.marks = {
  callback = function()
    Snacks.picker.marks()
  end,
  name = 'Go to mark',
}

M.previous_commit_message = {
  callback = function()
    vim.fn.execute('vsplit /tmp/PREV_COMMIT_EDITMSG')
  end,
  condition = function()
    local file_handle = io.open('/tmp/PREV_COMMIT_EDITMSG', 'r')

    return file_handle ~= nil
  end,
  name = 'Show previous commit message',
}

M.projects = {
  callback = function()
    Snacks.picker.projects()
  end,
  name = 'Load project',
}

M.recent_files = {
  callback = function()
    Snacks.picker.recent({
      filter = {
        cwd = true,
        filter = ignored_directory_filter,
      },
    })
  end,
  name = 'Recent files',
}

M.rename_symbol = {
  callback = function()
    vim.lsp.buf.rename()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = function(opts)
    return string.format('Rename symbol `%s`', opts.query)
  end,
}

M.resume = {
  callback = function()
    Snacks.picker.resume()
  end,
  name = 'Resume previous pickers',
}

M.review_diff_view = {
  callback = function()
    vim.cmd('CodeDiff origin/HEAD HEAD')
  end,
  condition = function()
    return git.is_inside_repo()
      and not vim.tbl_contains({ 'main', 'master' }, git.get_branch_name())
  end,
  name = 'Open diff view (PR review)',
}

M.search_and_replace = {
  callback = function()
    require('grug-far').open()
  end,
  name = 'Search and replace',
}

M.search_history = {
  callback = function()
    Snacks.picker.search_history()
  end,
  name = 'Search history',
}

M.spawn_file_manager = {
  callback = function()
    vim.system({ 'term', 'yazi' }, { detach = true }):wait()
  end,
  name = 'Spawn file manager',
}

M.spawn_file_manager_in_subdirectory = {
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
      utils.get_name_with_buffer_directory('Spawn file manager', opts)
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
  name = 'Spawn lazygit',
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
      utils.get_name_with_buffer_directory('Spawn lazygit', opts)
    )
  end,
}

M.spawn_terminal = {
  callback = function()
    vim.system({ 'term' }, { detach = true }):wait()
  end,
  name = 'Spawn terminal',
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
      utils.get_name_with_buffer_directory('Spawn terminal', opts)
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
  name = function(opts)
    return utils.get_short_path(
      utils.get_name_with_buffer_directory('Spawn claude', opts)
    )
  end,
}

M.spelling = {
  callback = function()
    Snacks.picker.spelling()
  end,
  name = 'Show spelling suggestions',
}

M.toggle_conceal_level = {
  callback = function(opts)
    vim.wo[opts.winnr].conceallevel = vim.wo[opts.winnr].conceallevel == 0 and 2
      or 0
  end,
  name = function(opts)
    return string.format(
      '%s character conceal',
      vim.wo[opts.winnr].conceallevel == 0 and 'Enable' or 'Disable'
    )
  end,
}

M.toggle_format_on_save = {
  callback = function()
    var.toggle_global('format_on_save')
  end,
  condition = function()
    local conform = require('lazy.core.config').plugins['conform.nvim']

    return conform ~= nil and conform._.loaded
  end,
  name = function()
    return string.format(
      '%s format on save',
      var.get_global('format_on_save') and 'Disable' or 'Enable'
    )
  end,
}

M.toggle_inline_diff = {
  callback = function(opts)
    require('mini.diff').toggle_overlay(opts.bufnr)
    var.toggle_buffer(opts.bufnr, 'git_diff')
  end,
  condition = function()
    local mini_diff = require('lazy.core.config').plugins['mini.diff']

    return git.is_inside_repo() and mini_diff ~= nil and mini_diff._.loaded
  end,
  name = function(opts)
    return string.format(
      '%s inline diff',
      var.get_buffer(opts.bufnr, 'git_diff') and 'Hide' or 'Show'
    )
  end,
}

M.toggle_relative_numbers = {
  callback = function(opts)
    vim.wo[opts.winnr].relativenumber = not vim.wo[opts.winnr].relativenumber
  end,
  name = function(opts)
    return string.format(
      '%s relative numbers',
      vim.wo[opts.winnr].relativenumber and 'Disable' or 'Enable'
    )
  end,
}

M.toggle_spell = {
  callback = function(opts)
    vim.wo[opts.winnr].spell = not vim.wo[opts.winnr].spell
  end,
  name = function(opts)
    return string.format(
      '%s spell checking',
      vim.wo[opts.winnr].spell and 'Disable' or 'Enable'
    )
  end,
}

M.toggle_wrap = {
  callback = function(opts)
    vim.wo[opts.winnr].wrap = not vim.wo[opts.winnr].wrap
  end,
  name = function(opts)
    return string.format(
      '%s line wrapping',
      vim.wo[opts.winnr].wrap and 'Disable' or 'Enable'
    )
  end,
}

M.undo = {
  callback = function()
    Snacks.picker.undo()
  end,
  name = 'Undo',
}

M.workspace_symbols = {
  callback = function()
    Snacks.picker.lsp_workspace_symbols()
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'Go to workspace symbol',
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
  name = 'Copy filename',
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
  name = 'Copy filename with line number',
}

M.yank_ring = {
  callback = function()
    Snacks.picker.yanky()
  end,
  name = 'Open yank ring',
}

return M
