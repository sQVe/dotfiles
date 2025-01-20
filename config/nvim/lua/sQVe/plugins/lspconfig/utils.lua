-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local map = require('sQVe.utils.map')

local M = {}

M.create_server_setup = function(opts)
  local capabilities = require('blink.cmp').get_lsp_capabilities()

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
    local manifest = vim.fs.dirname(
      vim.fs.find('package.json', { path = filename, upward = true })[1]
    )

    if opts.prioritizeManifest and manifest then
      return manifest
    end

    return vim.fs.dirname(
      vim.fs.find('.git', { path = filename, upward = true })[1]
    ) or manifest
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

  if client then
    if client.name == 'vtsls' then
      ignored_diagnostics = {
        { code = 7016, severity = severity.ERROR },
        { code = 80001, severity = severity.HINT },
      }
    elseif client.name == 'yamlls' then
      ignored_diagnostics = {
        { code = 'mapKeyOrder' },
      }
    end
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

M.map_diagnostic_keys = function(bufnr)
  local shared_diagnostic_opts = {
    float = false,
    severity = { min = vim.diagnostic.severity.WARN },
  }

  map('n', 'gl', function()
    vim.diagnostic.open_float({
      buffer = bufnr,
      header = '',
      severity_sort = true,
      source = true,
    })
  end, { buffer = bufnr, desc = 'View diagnostic (line)' })
  map('n', '[d', function()
    vim.diagnostic.jump(
      vim.tbl_extend('force', shared_diagnostic_opts, { count = -1 })
    )
  end, { buffer = bufnr, desc = 'Go to previous diagnostic' })
  map('n', ']d', function()
    vim.diagnostic.jump(
      vim.tbl_extend('force', shared_diagnostic_opts, { count = 1 })
    )
  end, { buffer = bufnr, desc = 'Go to next diagnostic' })
end

M.map_lookup_keys = function(bufnr)
  map({ 'n', 'v' }, 'ga', function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr, desc = 'Apply code action' })

  map(
    'n',
    'gd',
    Snacks.picker.lsp_definitions,
    { buffer = bufnr, desc = 'Go to definition' }
  )

  map(
    'n',
    'gD',
    Snacks.picker.lsp_declarations,
    { buffer = bufnr, desc = 'Go to declaration' }
  )

  map('n', 'gI', function()
    Snacks.picker.lsp_implementations({ reuse_win = true })
  end, { buffer = bufnr, desc = 'Go to implementation' })

  map(
    'n',
    'gr',
    Snacks.picker.lsp_references,
    { buffer = bufnr, desc = 'Go to reference' }
  )

  map('n', 'gR', function()
    vim.lsp.buf.rename()
  end, { buffer = bufnr, desc = 'Rename symbol' })

  map(
    'n',
    'gy',
    Snacks.picker.lsp_type_definitions,
    { buffer = bufnr, desc = 'Go to type definition' }
  )

  map(
    'n',
    'K',
    vim.lsp.buf.hover,
    { buffer = bufnr, desc = 'View symbol information' }
  )
end

return M
