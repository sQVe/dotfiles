-- ┏┓╻╻ ╻╻  ╻     ╻  ┏━┓
-- ┃┗┫┃ ┃┃  ┃     ┃  ┗━┓
-- ╹ ╹┗━┛┗━╸┗━╸   ┗━╸┗━┛
return function()
    local null = require('null-ls')
    local root_dir = require('util').root_dir

    local formatters = null.builtins.formatting
    local linters = null.builtins.diagnostics

    null.config({
        diagnostics_format = "#{c}: #{m} (#{s})",
        sources = {
            formatters.gofmt, formatters.lua_format, formatters.prettierd,
            formatters.shfmt
                .with({extra_args = {"-i", "2", "-bn", "-ci", "-sr"}}),
            linters.eslint_d, linters.shellcheck

        }
    })

    require("lspconfig")["null-ls"].setup({
        on_attach = function()
            vim.cmd([[
                augroup Format
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_sync()
                augroup END
            ]])
        end,
        root_dir = root_dir
    })
end
