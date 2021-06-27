--  ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
--  ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
--  ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
return function()
    vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_filetype_exclude = {"dashboard", "help", "packer"}
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_context_patterns = {
        "^for", "^if", "^object", "^table", "^while", "arguments", "block",
        "catch_clause", "class", "else_clause", "function", "if_statement",
        "import_statement", "jsx_element", "jsx_element",
        "jsx_self_closing_element", "method", "operation_type", "return",
        "try_statement"
    }
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_use_treesitter = true
end
