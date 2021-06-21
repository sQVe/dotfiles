require("plugins.lsp.compe")
require("plugins.lsp.fuzzy")
require("plugins.lsp.signature")
require("plugins.lsp.style")

local on_attach = function() require'lsp_signature'.on_attach() end
local servers = require('plugins.lsp.servers')(on_attach)

for server, config in pairs(servers) do
    require("lspconfig")[server].setup(config)
end
