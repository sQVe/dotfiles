-- ╻  ┏━┓┏━┓
-- ┃  ┗━┓┣━┛
-- ┗━╸┗━┛╹

local M = {}

M.create_base_setup = function(settings)
  local common_setup = {
    capabilities = M.update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    root_dir = M.create_root_dir_handler(),
  }

  return vim.tbl_extend('force', common_setup, settings or {})
end

M.create_runtime_condition = function(config_names)
  local starts_with = require('sQVe.utils.string').starts_with

  local bufnr_cache = {}
  local config_path_cache = {}

  return function(params)
    if bufnr_cache[params.bufnr] ~= nil then
      return bufnr_cache[params.bufnr]
    else
      for _, cached_config_path in ipairs(config_path_cache) do
        if starts_with(params.bufname, cached_config_path) then
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

  if client and client.name == 'tsserver' then
    -- More codes can be found here:
    -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
    local ignored_codes = { 80001 }

    result.diagnostics = vim.tbl_filter(function(diagnostic)
      return not vim.tbl_contains(ignored_codes, diagnostic.code)
    end, result.diagnostics)
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
M.map_lsp_buffer_keys = function(bufnr)
  local map = require('sQVe.utils.vim').map

  -- Format code.
  map(
    'n',
    '<Leader><Leader>',
    require('sQVe.utils.lsp').format,
    { buffer = bufnr }
  )

  -- Show LSP documetation under cursor.
  map('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })

  -- Show diagnostics for current line.
  map('n', 'gl', function()
    vim.diagnostic.open_float(
      0,
      { buffer = bufnr, header = false, scope = 'line' }
    )
  end)
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
