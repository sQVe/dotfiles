-- ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
-- ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
-- ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

local M = {}

local buffer = require('sQVe.utils.buffer')
local path = require('sQVe.utils.path')
local utils = require('sQVe.ui.command_palette.utils')
local var = require('sQVe.utils.var')

-- TODO: Toggles. (yos and etc)
-- TODO: Undo tree.
-- TODO: LSP commands.
--         - Rename
--         - Action
--         - Document symbols
--         - Workspace symbols
-- TODO: Notebox.
-- TODO: Move next and prev to default ] and [ bindings.
-- TODO: AI.

M.buffers = {
  callback = function()
    require('telescope.builtin').buffers({
      prompt_title = 'Go to buffer',
      sort_mru = true,
    })
  end,
  name = 'Go to buffer',
}

M.change_cwd_buffer_path = {
  callback = function(opts)
    vim.cmd(
      string.format(
        'cd %s',
        path.get_directory(buffer.get_buffer_path(opts.bufnr))
      )
    )
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
      and buffer.is_saved_buffer(opts.bufnr)
      and path.get_directory(buffer.get_buffer_path(opts.bufnr))
        ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_name_with_buffer_path('Change cwd', opts)
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
    return utils.get_name_with_git_root_path('Change cwd', opts)
  end,
}

M.commit_message_from_branch_name = {
  callback = function()
    local ok = pcall(vim.fn.execute, 'read !git branch --show-current')

    if ok then
      vim.api.nvim_command('normal kdd')
      vim.api.nvim_command('substitute /\\//: /e')
      vim.api.nvim_command('substitute /-/ /e')
      vim.api.nvim_command('nohl')
    end
  end,
  condition = function()
    local is_inside_git_repo = vim.fn.trim(
      vim.fn.system('git rev-parse --is-inside-work-tree')
    ) == 'true'

    return is_inside_git_repo
  end,
  name = 'Input commit message from branch name',
}

M.diagnostics = {
  callback = function()
    require('telescope.builtin').diagnostics({
      prompt_title = 'Go to diagnostic',
    })
  end,
  name = 'Go to diagnostic',
}

M.toggle_format_on_save = {
  callback = function()
    var.toggle_global_var('format_on_save')
  end,
  condition = function()
    local conform = require('lazy.core.config').plugins['conform.nvim']

    return conform ~= nil and conform._.loaded
  end,
  name = function()
    return string.format(
      '%s format on save',
      var.get_global_var('format_on_save') and 'Disable' or 'Enable'
    )
  end,
}

M.toggle_git_blame = {
  callback = function(opts)
    require('blame').toggle({ args = 'window' })
    var.toggle_buffer_var(opts.bufnr, 'git_blame')
  end,
  condition = function()
    local is_inside_git_repo = vim.fn.trim(
      vim.fn.system('git rev-parse --is-inside-work-tree')
    ) == 'true'

    return is_inside_git_repo
  end,
  name = function(opts)
    return string.format(
      '%s git blame window',
      var.get_buffer_var(opts.bufnr, 'git_blame') and 'Hide' or 'Show'
    )
  end,
}

M.toggle_git_diff_overlay = {
  callback = function(opts)
    require('mini.diff').toggle_overlay(opts.bufnr)
    var.toggle_buffer_var(opts.bufnr, 'git_diff')
  end,
  condition = function()
    local mini_diff = require('lazy.core.config').plugins['mini.diff']

    return mini_diff ~= nil and mini_diff._.loaded
  end,
  name = function(opts)
    return string.format(
      '%s git diff overlay',
      var.get_buffer_var(opts.bufnr, 'git_diff') and 'Hide' or 'Show'
    )
  end,
}

M.file_explorer = {
  callback = function()
    require('mini.files').open(buffer.get_buffer_path(), false)
  end,
  name = 'File explorer',
}

M.find_files = {
  callback = function()
    require('sQVe.plugins.telescope.pickers').find_files({
      prompt_title = 'Find file',
    })
  end,
  name = 'Find file',
}

M.find_files_in_subdirectory = {
  callback = function(opts)
    require('sQVe.plugins.telescope.pickers').find_files({
      cwd = path.get_directory(buffer.get_buffer_path(opts.bufnr)),
      prompt_title = utils.get_name_with_buffer_path('Find file', opts),
    })
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
      and buffer.is_saved_buffer(opts.bufnr)
      and path.get_directory(buffer.get_buffer_path(opts.bufnr))
        ~= path.get_cwd()
  end,
  name = 'Find file from buffer path',
}

M.git_status = {
  callback = function(opts)
    require('sQVe.plugins.telescope.pickers').git_status(
      vim.tbl_extend('force', opts, {
        prompt_title = 'Git status',
        use_git_root = true,
      })
    )
  end,
  condition = function()
    local is_inside_git_repo = vim.fn.trim(
      vim.fn.system('git rev-parse --is-inside-work-tree')
    ) == 'true'
    local has_changed_files = vim.fn.trim(
      vim.fn.system('git status --porcelain')
    ) ~= ''

    return is_inside_git_repo and has_changed_files
  end,
  name = 'Git status',
}

M.grep_text = {
  callback = function(opts)
    require('telescope.builtin').grep_string({
      prompt_title = string.format(
        'Grep %s `%s`',
        opts.is_visual_mode and 'selection' or 'word',
        opts.query
      ),
      search = opts.query,
    })
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
  end,
  name = function(opts)
    return string.format(
      'Grep %s `%s`',
      opts.is_visual_mode and 'selection' or 'word',
      opts.query
    )
  end,
}

M.lazygit = {
  callback = function()
    vim.system({ 'term', 'lazygit' }, { detach = true }):wait()
  end,
  name = 'Spawn lazygit',
}

M.lazygit_with_filter = {
  callback = function(opts)
    vim
      .system({
        'term',
        'lazygit',
        '--filter',
        buffer.get_buffer_path(opts.bufnr),
      }, { detach = true })
      :wait()
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
      and buffer.is_saved_buffer(opts.bufnr)
  end,
  name = 'Spawn lazygit from buffer path',
}

M.live_grep = {
  callback = function()
    require('telescope.builtin').live_grep({
      prompt_title = 'Live grep',
    })
  end,
  name = 'Live grep',
}

M.live_grep_in_subdirectory = {
  callback = function(opts)
    require('telescope.builtin').live_grep({
      cwd = path.get_directory(buffer.get_buffer_path(opts.bufnr)),
      prompt_title = utils.get_name_with_buffer_path('Live grep', opts),
    })
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
      and buffer.is_saved_buffer(opts.bufnr)
      and path.get_directory(buffer.get_buffer_path(opts.bufnr))
        ~= path.get_cwd()
  end,
  name = 'Live grep from buffer path',
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

M.recent_files = {
  callback = function()
    require('telescope.builtin').oldfiles({
      cwd_only = true,
      prompt_title = 'Recent files',
      sort_lastused = true,
    })
  end,
  name = 'Recent files',
}

M.resume = {
  callback = function()
    require('telescope.builtin').pickers({
      prompt_title = 'Resume past picker',
    })
  end,
  name = 'Resume past picker',
}

M.search_history = {
  callback = function()
    require('telescope.builtin').search_history({
      prompt_title = 'Search history',
    })
  end,
  name = 'Search history',
}

M.terminal = {
  callback = function()
    vim.system({ 'term' }, { detach = true }):wait()
  end,
  name = 'Spawn terminal',
}

M.terminal_in_subdirectory = {
  callback = function(opts)
    vim
      .system({
        'term',
        path.get_directory(buffer.get_buffer_path(opts.bufnr)),
      }, { detach = true })
      :wait()
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
      and buffer.is_saved_buffer(opts.bufnr)
      and path.get_directory(buffer.get_buffer_path(opts.bufnr))
        ~= path.get_cwd()
  end,
  name = 'Spawn terminal from buffer path',
}

M.yazi = {
  callback = function()
    vim.system({ 'term', 'yazi' }, { detach = true }):wait()
  end,
  name = 'Spawn yazi',
}

M.yazi_in_subdirectory = {
  callback = function(opts)
    vim
      .system({
        'term',
        'yazi',
        buffer.get_buffer_path(opts.bufnr),
      }, { detach = true })
      :wait()
  end,
  condition = function(opts)
    return buffer.is_valid_buffer(opts.bufnr)
      and buffer.is_saved_buffer(opts.bufnr)
  end,
  name = 'Spawn yazi from buffer path',
}

return M
