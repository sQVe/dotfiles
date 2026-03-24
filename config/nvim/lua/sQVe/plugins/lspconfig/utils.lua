-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local map = require('sQVe.utils.map')

local M = {}

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
    if client.name == 'tsgo' then
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

M.setup_copilot_commands = function(client, bufnr)
  client:request('checkStatus', { localChecksOnly = false }, function(_, result)
    if result and result.status == 'NotSignedIn' then
      vim.notify('Copilot is not signed in. Run :CopilotSignIn', vim.log.levels.WARN)
    end
  end, bufnr)

  vim.api.nvim_buf_create_user_command(bufnr, 'CopilotSignIn', function()
    client:request('signIn', vim.empty_dict(), function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.status == 'AlreadySignedIn' then
        vim.notify('Already signed in as ' .. result.user)
      elseif result.userCode then
        vim.fn.setreg('+', result.userCode)
        vim.notify('Code copied to clipboard: ' .. result.userCode)
        vim.fn.system({ 'mimeo', result.verificationUri })
      end
    end, bufnr)
  end, {})

  vim.api.nvim_buf_create_user_command(bufnr, 'CopilotSignOut', function()
    client:request('signOut', vim.empty_dict(), function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      vim.notify(result.status == 'NotSignedIn' and 'Signed out' or vim.inspect(result))
    end, bufnr)
  end, {})
end

return M
