-- ╻  ┏━┓┏━┓
-- ┃  ┗━┓┣━┛
-- ┗━╸┗━┛╹

local M = {}

M.create_diagnostics_handler = function(ignored_codes)
  return function(...)
    local params = select(2, ...)

    if params.diagnostics ~= nil then
      for idx, diagnostic in ipairs(params.diagnostics) do
        for _, code in ipairs(ignored_codes) do
          if diagnostic.code == code then
            table.remove(params.diagnostics, idx)
          end
        end
      end
    end

    vim.lsp.handlers['textDocument/publishDiagnostics'](...)
  end
end

M.create_base_setup = function(settings)
  local common_setup = {
    capabilities = M.update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    root_dir = M.create_root_dir_handler(),
  }

  return vim.tbl_extend('force', common_setup, settings or {})
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
