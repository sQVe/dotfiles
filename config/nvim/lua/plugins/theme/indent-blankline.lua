--  ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
--  ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
--  ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
return function()
    vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_filetype_exclude = {"dashboard", "help", "packer"}
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_show_first_indent_level = false
    -- Patterns: https://github.com/tree-sitter/tree-sitter-typescript/blob/master/tsx/src/node-types.json
    vim.g.indent_blankline_context_patterns = {
        "declaration", "expression", "pattern", "primary_expression",
        "statement", "switch_body"
    }
    vim.g.indent_blankline_use_treesitter = true
end
