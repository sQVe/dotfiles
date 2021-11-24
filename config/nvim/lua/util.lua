-- ╻ ╻╺┳╸╻╻
-- ┃ ┃ ┃ ┃┃
-- ┗━┛ ╹ ╹┗━╸
local util = require('lspconfig').util

local M = {}

function M.root_dir(opts)
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

        return util.find_git_ancestor(filename)
            or manifest
            or util.path.dirname(filename)
    end
end

return M
