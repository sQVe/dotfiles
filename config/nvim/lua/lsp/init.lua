require("lsp/compe")
require("lsp/fuzzy")
require("lsp/signature")
require("lsp/style")

local on_attach = function() require'lsp_signature'.on_attach() end
local servers = require('lsp/servers')(on_attach)

for server, config in pairs(servers) do
    require("lspconfig")[server].setup(config)
end
