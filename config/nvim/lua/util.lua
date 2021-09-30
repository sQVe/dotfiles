-- ╻ ╻╺┳╸╻╻
-- ┃ ┃ ┃ ┃┃
-- ┗━┛ ╹ ╹┗━╸
local util = require("lspconfig").util

local M = {}

function M.root_dir(filename)
    local manifest_file

    if string.match(filename, '%.go$') then
        manifest_file = util.root_pattern('go.mod')(filename)
    else
        manifest_file = util.find_package_json_ancestor(filename)
    end

    return util.find_git_ancestor(filename) or manifest_file or
               util.path.dirname(filename)
end

return M
