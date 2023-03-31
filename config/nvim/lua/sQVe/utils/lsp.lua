-- ╻  ┏━┓┏━┓
-- ┃  ┗━┓┣━┛
-- ┗━╸┗━┛╹

local M = {}

M.create_server_setup = function(opts)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local common_setup = {
    capabilities = capabilities,
    root_dir = M.create_root_dir_handler(),
  }

  return vim.tbl_extend('force', common_setup, opts or {})
end

M.create_runtime_condition = function(config_names)
  local string_starts_with = require('sQVe.utils.lua').string_starts_with

  local bufnr_cache = {}
  local config_path_cache = {}

  return function(params)
    if bufnr_cache[params.bufnr] ~= nil then
      return bufnr_cache[params.bufnr]
    else
      for _, cached_config_path in ipairs(config_path_cache) do
        if string_starts_with(params.bufname, cached_config_path) then
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

    if string.match(filename, '%.go$') then
      manifest = util.root_pattern('go.mod')(filename)
    else
      manifest = util.find_package_json_ancestor(filename)
    end

    if opts.prioritizeManifest and manifest then
      return manifest
    end

    return util.find_git_ancestor(filename) or manifest
  end
end

M.diagnostic_handler = function(_, result, ctx, ...)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  if client then
    if client.name == 'tsserver' then
      -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
      local ignored_codes = { 80001 }

      result.diagnostics = vim.tbl_filter(function(diagnostic)
        return not vim.tbl_contains(ignored_codes, diagnostic.code)
      end, result.diagnostics)
    elseif client.name == 'yamlls' then
      result.diagnostics = vim.tbl_filter(function(diagnostic)
        local ignored_codes = { 'mapKeyOrder' }

        return not vim.tbl_contains(ignored_codes, diagnostic.code)
      end, result.diagnostics)
    end
  end

  return vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, ...)
end

M.format = function(bufnr, async)
  async = async == nil and true or false

  vim.lsp.buf.format({
    async = async,
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
    timeout_ms = 20000,
  })
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
          header = false,
          scope = 'line',
        })
      end, { buffer = bufnr, desc = 'View diagnostics (line)' })
      map('n', '<Leader>ll', function()
        builtin.diagnostics({ bufnr = 0 })
      end, { buffer = bufnr, desc = 'List diagnostics (buffer)' })
      map(
        'n',
        '<Leader>lo',
        builtin.diagnostics,
        { buffer = bufnr, desc = 'List diagnostics (open buffers)' }
      )
    end,
    formatting = function()
      map(
        'n',
        '<Leader><Leader>',
        require('sQVe.utils.lsp').format,
        { buffer = bufnr, desc = 'Format with LSP' }
      )
    end,
    lookup = function()
      map(
        'n',
        'gd',
        builtin.lsp_definitions,
        { buffer = bufnr, desc = 'Goto definitions' }
      )
      map(
        'n',
        'gD',
        builtin.lsp_implementations,
        { buffer = bufnr, desc = 'Goto implementations' }
      )
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
      map('n', '<Leader>s', function()
        require('nvim-navbuddy').open()
      end, { buffer = bufnr, desc = 'Goto buffer symbols tree' })
      map(
        'n',
        '<Leader>S',
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

-- Mirror capabilities set by `update_capabilities` in `cmp-nvim-lsp`, since
-- we want to decouple LSP from it.
-- https://github.com/hrsh7th/cmp-nvim-lsp/blob/main/lua/cmp_nvim_lsp/init.lua.
M.update_capabilities = function(capabilities)
  local completionItem = capabilities.textDocument.completion.completionItem

  completionItem.commitCharactersSupport = true
  completionItem.deprecatedSupport = true
  completionItem.insertReplaceSupport = true
  completionItem.labelDetailsSupport = true
  completionItem.preselectSupport = true
  completionItem.resolveSupport = {
    properties = { 'additionalTextEdits', 'detail', 'documentation' },
  }
  completionItem.snippetSupport = true
  completionItem.tagSupport = { valueSet = { 1 } }

  return capabilities
end

return M
