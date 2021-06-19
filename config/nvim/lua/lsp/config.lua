--  ┏━╸┏━┓┏┓╻┏━╸╻┏━╸
--  ┃  ┃ ┃┃┗┫┣╸ ┃┃╺┓
--  ┗━╸┗━┛╹ ╹╹  ╹┗━┛

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})

local on_attach = function() require'lsp_signature'.on_attach() end

-- Linters and formatters.
local luaformat = {formatCommand = "lua-format -i", formatStdin = true}

local eslint = {
    formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename ${INPUT}",
    formatStdin = true,
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    lintIgnoreExitCode = true,
    lintStdin = true
}

local gofmt = {formatCommand = "gofmt"}

local shellcheck = {
    lintCommand = "shellcheck -f gcc -x",
    lintFormats = {
        "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
    }
}

local shfmt = {formatCommand = 'shfmt -i 2 -bn -ci -sr', formatStdin = true}

local prettier = {
    formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
    formatStdin = true
}

-- Servers.
lspconfig.bashls.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.jsonls.setup {}
lspconfig.yamlls.setup {}
lspconfig.sumneko_lua.setup {
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            diagnostics = {globals = {'vim'}},
            runtime = {version = 'LuaJIT'},
            telemetry = {enable = false}
        }
    }
};
lspconfig.gopls.setup {
    root_dir = function(filename)
        return util.root_pattern("go.mod", ".git")(filename) or
                   util.path.dirname(filename)
    end
}

lspconfig.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach()
    end
}

lspconfig.efm.setup {
    cmd = {"efm-langserver"},
    on_attach = function(client)
        client.resolved_capabilities.completion = false
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.hover = false
        client.resolved_capabilities.rename = false

        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api
            .nvim_command [[autocmd BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_seq_sync()]]
        vim.api.nvim_command [[augroup END]]
    end,
    init_options = {codeAction = true, documentFormatting = true},
    filetypes = {
        "css", "go", "html", "javascript", "javascriptreact", "json", "jsonc",
        "lua", "markdown", "scss", "sh", "typescript", "typescriptreact", "yaml"
    },
    root_dir = function(filename)
        return util.root_pattern("package.json", "go.mod", ".git")(filename) or
                   util.path.dirname(filename)
    end,
    settings = {
        languages = {
            css = {prettier},
            go = {gofmt},
            html = {prettier},
            javascript = {eslint, prettier},
            javascriptreact = {eslint, prettier},
            json = {prettier},
            jsonc = {prettier},
            lua = {luaformat},
            markdown = {prettier},
            scss = {prettier},
            sh = {shellcheck, shfmt},
            typescript = {eslint, prettier},
            typescriptreact = {eslint, prettier},
            yaml = {prettier}
        }
    }
}
