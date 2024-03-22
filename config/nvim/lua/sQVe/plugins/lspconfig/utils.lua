-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.create_server_setup = function(opts)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  capabilities.workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
  }

  local common_setup = {
    capabilities = capabilities,
    root_dir = M.create_root_dir_handler(),
  }

  return vim.tbl_extend('force', common_setup, opts or {})
end

M.create_runtime_condition = function(config_names)
  local bufnr_cache = {}
  local config_path_cache = {}

  return function(params)
    if bufnr_cache[params.bufnr] ~= nil then
      return bufnr_cache[params.bufnr]
    else
      for _, cached_config_path in ipairs(config_path_cache) do
        if vim.startswith(params.bufname, cached_config_path) then
          bufnr_cache[params.bufnr] = true
          return true
        end
      end
    end

    local config_path =
      require('lspconfig').util.root_pattern(config_names)(params.bufname)

    local has_config = config_path ~= nil
    if has_config then
      table.insert(config_path_cache, config_path)
    end
    bufnr_cache[params.bufnr] = has_config

    return has_config
  end
end

M.create_root_dir_handler = function(opts)
  local util = require('lspconfig').util

  opts = opts or { prioritizeManifest = false }

  return function(filename)
    local manifest

    manifest = util.find_package_json_ancestor(filename)

    if opts.prioritizeManifest and manifest then
      return manifest
    end

    return util.find_git_ancestor(filename) or manifest
  end
end

M.diagnostic_handler = function(_, result, ctx, ...)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local ignored_diagnostics = {}
  local severity = {
    ERROR = 1,
    WARNING = 2,
    INFO = 3,
    HINT = 4,
  }

  if client and client.name == 'typescript-tools' then
    ignored_diagnostics = {
      { code = 7016, severity = severity.ERROR },
      { code = 80001, severity = severity.HINT },
    }
  elseif client and client.name == 'yamlls' then
    ignored_diagnostics = {
      { code = 'mapKeyOrder' },
    }
  end

  result.diagnostics = vim.tbl_filter(function(diagnostic)
    for _, ignored_diagnostic in ipairs(ignored_diagnostics) do
      local ignore = true

      for key, value in pairs(ignored_diagnostic) do
        if diagnostic[key] ~= value then
          ignore = false
          break
        end
      end

      if ignore then
        return false
      end
    end

    return true
  end, result.diagnostics)

  return vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, ...)
end

function M.enable_code_lens(bufnr, allowed_filetypes)
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })

  if vim.tbl_contains(allowed_filetypes, filetype) then
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end
end

-- Map keys for buffers which has LSP enabled.
M.map_lsp_buffer_keys = function(bufnr, include)
  include = include or {}

  local builtin = require('telescope.builtin')
  local map = require('sQVe.utils.vim').map
  local includeMap = {
    diagnostics = function()
      map('n', 'gl', function()
        vim.diagnostic.open_float({
          buffer = bufnr,
          header = '',
          severity_sort = true,
          source = true,
        })
      end, { buffer = bufnr, desc = 'View diagnostics (line)' })
      map('n', '<Leader>dd', function()
        builtin.diagnostics({ bufnr = 0 })
      end, { buffer = bufnr, desc = 'Goto diagnostics' })
    end,
    lookup = function()
      map(
        'n',
        'gd',
        builtin.lsp_definitions,
        { buffer = bufnr, desc = 'Goto definitions' }
      )
      map('n', 'gD', function()
        local filetype =
          vim.api.nvim_get_option_value('filetype', { buf = bufnr })

        local typescript_tools_filetypes =
          require('sQVe.plugins.typescript-tools').ft

        if vim.tbl_contains(typescript_tools_filetypes, filetype) then
          require('typescript-tools.api').go_to_source_definition()
          return
        end

        vim.lsp.buf.declaration()
      end, { buffer = bufnr, desc = 'Goto declaration' })
      map('n', 'gI', function()
        builtin.lsp_implementations({ reuse_win = true })
      end, { buffer = bufnr, desc = 'Goto implementations' })
      map(
        'n',
        'gr',
        builtin.lsp_references,
        { buffer = bufnr, desc = 'Goto references' }
      )
      map(
        'n',
        'gy',
        builtin.lsp_type_definitions,
        { buffer = bufnr, desc = 'Goto type definitions' }
      )
      map(
        'n',
        'K',
        vim.lsp.buf.hover,
        { buffer = bufnr, desc = 'View symbol information' }
      )
      map(
        'n',
        '<Leader>s',
        builtin.lsp_document_symbols,
        { buffer = bufnr, desc = 'Goto buffer symbols' }
      )
      map(
        'n',
        '<Leader>w',
        builtin.lsp_dynamic_workspace_symbols,
        { buffer = bufnr, desc = 'Goto workspace symbols' }
      )
    end,
  }

  for _, includeKey in pairs(include) do
    includeMap[includeKey]()
  end
end

return M
