-- ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
-- ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
-- ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

local M = {}

local buffer = require('sQVe.utils.buffer')
local git = require('sQVe.utils.git')
local path = require('sQVe.utils.path')
local utils = require('sQVe.ui.command_palette.utils')
local var = require('sQVe.utils.var')

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
      string.format('cd %s', path.get_parent(buffer.get_path(opts.bufnr)))
    )
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
  end,
  name = function(opts)
    return utils.get_name_with_buffer_directory('Change cwd', opts)
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
    require('telescope.builtin').command_history({
      prompt_title = 'Command history',
    })
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
    require('telescope.builtin').diagnostics({
      prompt_title = 'Go to diagnostic',
    })
  end,
  name = 'Go to diagnostic',
}

M.diff_view = {
  callback = function()
    vim.cmd('DiffviewOpen')
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Open diff view',
}

M.document_symbols = {
  callback = function()
    require('telescope.builtin').lsp_document_symbols({
      prompt_title = 'Go to document symbol',
    })
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

M.file_history = {
  callback = function()
    vim.cmd('DiffviewFileHistory')
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = 'Open file history',
}

M.file_history_buffer_path = {
  callback = function()
    vim.cmd('DiffviewFileHistory %')
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and git.is_inside_repo()
  end,
  name = function(opts)
    return utils.get_name_with_buffer_path('Open file history', opts)
  end,
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
      cwd = path.get_parent(buffer.get_path(opts.bufnr)),
      prompt_title = utils.get_name_with_buffer_directory('Find file', opts),
    })
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
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
    return git.is_inside_repo() and git.has_changed_files()
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

M.help_tags = {
  callback = function()
    require('telescope.builtin').help_tags({
      prompt_title = 'Go to help tag',
    })
  end,
  name = 'Go to help tag',
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
      cwd = path.get_parent(buffer.get_path(opts.bufnr)),
      prompt_title = utils.get_name_with_buffer_directory('Live grep', opts),
    })
  end,
  condition = function(opts)
    return buffer.is_valid(opts.bufnr)
      and buffer.is_saved(opts.bufnr)
      and path.get_parent(buffer.get_path(opts.bufnr)) ~= path.get_cwd()
  end,
  name = 'Live grep from buffer path',
}

M.markdown_preview = {
  callback = function()
    vim.cmd('MarkdownPreview')
  end,
  condition = function(opts)
    return vim.bo[opts.bufnr].filetype == 'markdown'
  end,
  name = 'Start markdown preview',
}

M.marks = {
  callback = function()
    require('telescope.builtin').marks({
      prompt_title = 'Go to mark',
    })
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
    require('telescope.builtin').pickers({
      prompt_title = 'Resume previous pickers',
    })
  end,
  name = 'Resume previous pickers',
}

M.review_diff_view = {
  callback = function()
    vim.cmd('DiffviewOpen origin/HEAD...HEAD')
  end,
  condition = function()
    return git.is_inside_repo()
      and not vim.tbl_contains({ 'main', 'master' }, git.get_branch_name())
  end,
  name = 'Open diff view (PR review)',
}

M.search_and_replace = {
  callback = function()
    require('grug-far').grug_far()
  end,
  name = 'Search and replace',
}

M.search_history = {
  callback = function()
    require('telescope.builtin').search_history({
      prompt_title = 'Search history',
    })
  end,
  name = 'Search history',
}

M.smart_open = {
  callback = function()
    require('telescope').extensions.smart_open.smart_open({
      filename_first = false,
      cwd_only = true,
    })
  end,
  name = 'Smart open',
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
  name = 'Spawn file file manager from buffer path',
}

M.spawn_lazygit = {
  callback = function()
    vim.system({ 'term', 'lazygit' }, { detach = true }):wait()
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
    return buffer.is_valid(opts.bufnr) and buffer.is_saved(opts.bufnr)
  end,
  name = 'Spawn lazygit from buffer filter',
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
  name = 'Spawn terminal from buffer path',
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

M.toggle_git_blame = {
  callback = function(opts)
    vim.cmd('BlameToggle')
    var.toggle_buffer(opts.bufnr, 'git_blame')
  end,
  condition = function()
    return git.is_inside_repo()
  end,
  name = function(opts)
    return string.format(
      '%s git blame window',
      var.get_buffer(opts.bufnr, 'git_blame') and 'Hide' or 'Show'
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

M.workspace_symbols = {
  callback = function()
    require('telescope.builtin').lsp_workspace_symbols({
      prompt_title = 'Go to workspace symbol',
    })
  end,
  condition = function(opts)
    local lspconfig = require('sQVe.plugins.lspconfig')

    return vim.tbl_contains(lspconfig.ft, vim.bo[opts.bufnr].filetype)
  end,
  name = 'Go to workspace symbol',
}

return M
