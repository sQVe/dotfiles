--  ┏━┓╺┳╸╻ ╻╻  ┏━╸
--  ┗━┓ ┃ ┗┳┛┃  ┣╸
--  ┗━┛ ╹  ╹ ┗━╸┗━╸
-- Disable virtual text for diagnostics.
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})

